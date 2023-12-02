
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_basic_app/core/api_service.dart';
import 'package:e_commerce_basic_app/core/failures.dart';
import 'package:e_commerce_basic_app/feature/home/data/model/products_model.dart';
import 'package:flutter/cupertino.dart';
import 'favorites_repo.dart';

class FavoritesRepoImpl implements FavoritesRepo {
  final ApiService apiService;

  FavoritesRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<ProductsModel>>> getProducts() async {
    try {
      var response = await apiService.get(endPoint: 'products');

      if (200 <= response.code && response.code <= 300) {
        List<dynamic> responseData = response.data;
        List<ProductsModel> products = responseData.map((item) => ProductsModel.fromJson(item)).toList();
        return right(products);
      } else {
        return left(Failure(response.errorMessage));
      }
    } catch (e) {
      if (e is DioError) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(ServerFailure(
        e.toString(),
      ));
    }
  }
}
