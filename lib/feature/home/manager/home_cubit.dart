import 'package:bloc/bloc.dart';
import 'package:e_commerce_basic_app/feature/home/data/repo/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repo) : super(HomeState.initial());
  final HomeRepo repo;



  void getCategories() async {
    emit(state.copyWith(status: HomeStatus.submitting));
    var result = await repo.getCategories();
    result.fold((failure) {
      emit(state.copyWith(failure: failure, status: HomeStatus.error));
    }, (model) async {
      emit(state.copyWith(categories: model));

    //  get products for first item
      var result = await repo.getProductCategory(model.first);
      result.fold((failure) {
        emit(state.copyWith(failure: failure, status: HomeStatus.error));
      }, (model) {
        emit(state.copyWith(status: HomeStatus.success, model: model));
        emit(state.copyWith(productsStatus: ProductsStatus.success, model: model));
      });


    });
  }

   void getProductCategory(String category) async {
     emit(state.copyWith(productsStatus: ProductsStatus.submitting));
     var result = await repo.getProductCategory(category);
    result.fold((failure) {
      emit(state.copyWith(failure: failure, productsStatus: ProductsStatus.error));
    }, (model) {
      emit(state.copyWith(productsStatus: ProductsStatus.success, model: model));
    });
  }


  void changeSelectedCategories(String value) {
    emit(state.copyWith(selectedCategories: value));
  }
  void changeSelectedCategoryIndex(int value) {
    emit(state.copyWith(selectedCategoryIndex: value));
  }



}
