

import 'package:e_commerce_basic_app/feature/home/data/model/products_model.dart';
import 'package:equatable/equatable.dart';

import '../../../core/failures.dart';

enum FavoritesStatus { initial, submitting, success, error }


class FavoritesState extends Equatable {
  final FavoritesStatus status;
  final List<ProductsModel> model;
  final Failure failure;


  const FavoritesState({
    required this.status,
    required this.model,
    required this.failure
  });

  factory FavoritesState.initial() {
    return const FavoritesState(
      status: FavoritesStatus.initial,
      model: [],
      failure: Failure("")
    );
  }

  @override
  List<Object> get props => [status, model,failure];

  FavoritesState copyWith(
      {
        FavoritesStatus? status,
        Failure? failure,
        List<ProductsModel>? model
      }) {
    return FavoritesState(
      status: status ?? this.status,
      model: model ?? this.model,
      failure: failure ?? this.failure,

    );
  }
}
