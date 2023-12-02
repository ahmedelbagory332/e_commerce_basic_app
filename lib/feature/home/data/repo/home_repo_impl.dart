
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_basic_app/core/api_service.dart';
import 'package:e_commerce_basic_app/core/failures.dart';
import 'package:e_commerce_basic_app/feature/home/data/model/products_model.dart';
import 'package:flutter/cupertino.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);



  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      var response =
      await apiService.get(endPoint: 'products/categories');

      if (200 <= response.code && response.code <= 300) {
        List<dynamic> responseData = response.data;
        List<String> categories = responseData.map((item) => item.toString()).toList();

        return right(categories);
      } else {
        debugPrint("1234 ${response.errorMessage}");

        return left(Failure(response.errorMessage));
      }
    } catch (e) {
      debugPrint("12345 ${ServerFailure(e.toString()).errMessage}");

      if (e is DioError) {
        debugPrint("123456 ${ServerFailure.fromDioError(e).errMessage}");

        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(ServerFailure(
        e.toString(),
      ));

    }
  }

  @override
  Future<Either<Failure, List<ProductsModel>>> getProductCategory(String category)  async {
    try {
      var response = await apiService.get(endPoint: 'products/category/$category');

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
