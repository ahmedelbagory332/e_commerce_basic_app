import 'package:dartz/dartz.dart';
import 'package:e_commerce_basic_app/core/failures.dart';
import 'package:e_commerce_basic_app/feature/home/data/model/products_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<String>>> getCategories();
  Future<Either<Failure, List<ProductsModel>>> getProductCategory(String category);
}
