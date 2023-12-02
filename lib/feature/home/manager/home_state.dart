

import 'package:e_commerce_basic_app/feature/home/data/model/products_model.dart';
import 'package:equatable/equatable.dart';

import '../../../core/failures.dart';

enum HomeStatus { initial, submitting, success, error }
enum ProductsStatus { initial, submitting, success, error }


class HomeState extends Equatable {
  final HomeStatus status;
  final ProductsStatus productsStatus;
  final List<ProductsModel> model;
  final List<String> categories;
  final Failure failure;
  final String selectedCategories;
  final int selectedCategoryIndex;


  const HomeState({
    required this.status,
    required this.productsStatus,
    required this.model,
    required this.failure,
    required this.categories,
    required this.selectedCategories,
    required this.selectedCategoryIndex
  });

  factory HomeState.initial() {
    return const HomeState(
      status: HomeStatus.initial,
      productsStatus: ProductsStatus.initial,
      model: [],
      categories: [],
      failure: Failure(""),
      selectedCategories: "",
      selectedCategoryIndex: 0,

    );
  }

  @override
  List<Object> get props => [status,productsStatus,selectedCategoryIndex,selectedCategories, model, categories,failure];

  HomeState copyWith(
      {
        HomeStatus? status,
        ProductsStatus? productsStatus,
        List<String>? categories,
        Failure? failure,
        String? selectedCategories,
        int? selectedCategoryIndex,
        List<ProductsModel>? model}) {
    return HomeState(
      status: status ?? this.status,
      productsStatus: productsStatus ?? this.productsStatus,
      model: model ?? this.model,
      categories: categories ?? this.categories,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedCategoryIndex: selectedCategoryIndex ?? this.selectedCategoryIndex,
      failure: failure ?? this.failure,

    );
  }
}
