import 'package:bloc/bloc.dart';
import 'package:e_commerce_basic_app/core/failures.dart';
import 'package:e_commerce_basic_app/feature/cart/manager/cart_state.dart';
import 'package:flutter/cupertino.dart';
import '../data/model/cart_model.dart';
import '../data/sqlite/CacheCart.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.initial());

  final CashCart _cashCart = CashCart();


  void getCart() async {
    emit(state.copyWith(status: CartStatus.submitting));
    try{
      var result = await _cashCart.getProducts();

      emit(state.copyWith(products: result, status: CartStatus.success));
    }catch(e){
      debugPrint("cart get error  ${e.toString()}");

      emit(state.copyWith(failure: ServerFailure(e.toString()), status: CartStatus.error));
    }
  }

  void addQuantity(CartModel cart) {
    cart.quantity = (int.parse(cart.quantity!) + 1).toString();
    productsUpdate(cart);
  }

  void deleteQuantity(CartModel cart) {
    final currentQuantity = int.parse(cart.quantity!);
    if (currentQuantity <= 1) {
      currentQuantity == 1;
    } else {
      cart.quantity = (int.parse(cart.quantity!) - 1).toString();
      productsUpdate(cart);
    }
  }

  void removeProduct(id) async {
    try{
     _cashCart.removeProduct(id).then((value){
        getCart();
      });
    }catch(e){
      debugPrint("cart rm error  ${e.toString()}");
      emit(state.copyWith(failure: ServerFailure(e.toString()), status: CartStatus.error));
    }
  }

 void productsUpdate(CartModel cartModel) async {
    try{
       await _cashCart.productsUpdate(cartModel).then((value){
         debugPrint("update  ${value.toString()}");
         getCart();
       });
    }catch(e){
      debugPrint(" cart update error  ${e.toString()}");
      emit(state.copyWith(failure: ServerFailure(e.toString()), status: CartStatus.error));
    }
  }

  void insertProduct(CartModel cartModel) async {
    try{
      var products = await _cashCart.getProducts();
          if(products!.any((element) => element.title==cartModel.title)){
            emit(state.copyWith(failure: ServerFailure("product already in cart"), addToCartStatus: AddToCartStatus.error));
          }else {
            _cashCart.insertProduct(cartModel).then((result){
          debugPrint("id row  ${result.toString()}");
          emit(state.copyWith(addToCartStatus: AddToCartStatus.success));

            });
          }
    }catch(e){
      debugPrint("cart insert error  ${e.toString()}");
      emit(state.copyWith(failure: ServerFailure(e.toString()), addToCartStatus: AddToCartStatus.error));
    }
  }



}
