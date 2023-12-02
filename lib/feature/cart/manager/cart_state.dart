import 'package:e_commerce_basic_app/feature/home/data/model/products_model.dart';
import 'package:equatable/equatable.dart';
import '../../../core/failures.dart';
import '../data/model/cart_model.dart';

enum CartStatus { initial, submitting, success, error }
enum AddToCartStatus { initial, submitting, success, error }

class CartState extends Equatable {
  final CartStatus status;
  final AddToCartStatus addToCartStatus;
  final List<CartModel> products;
  final Failure failure;

  const CartState({
    required this.status,
    required this.addToCartStatus,
    required this.products,
    required this.failure,
  });

  factory CartState.initial() {
    return const CartState(
      status: CartStatus.initial,
      addToCartStatus: AddToCartStatus.initial,
      products: [],
      failure: Failure("")
    );
  }

  @override
  List<Object> get props => [status,addToCartStatus,products,failure];

  CartState copyWith(
      {
        CartStatus? status,
        AddToCartStatus? addToCartStatus,
        Failure? failure,
        List<CartModel>? products
      }) {
    return CartState(
      status: status ?? this.status,
      addToCartStatus: addToCartStatus ?? this.addToCartStatus,
      products: products ?? this.products,
      failure: failure ?? this.failure,

    );
  }
}
