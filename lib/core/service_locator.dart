
import 'package:dio/dio.dart';
import 'package:e_commerce_basic_app/feature/favorites/data/repo/favorites_repo_impl.dart';
import 'package:e_commerce_basic_app/feature/home/data/repo/home_repo_impl.dart';
import 'package:get_it/get_it.dart';
import 'api_service.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {

  getIt.registerSingleton<ApiService>(
      ApiService(Dio()));

  getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(
    getIt.get<ApiService>()
  ));

  getIt.registerSingleton<FavoritesRepoImpl>(FavoritesRepoImpl(
    getIt.get<ApiService>()
  ));


}


