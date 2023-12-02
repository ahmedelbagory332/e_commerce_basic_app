import 'package:bloc/bloc.dart';
import '../data/repo/favorites_repo.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this.repo) : super(FavoritesState.initial());
  final  FavoritesRepo repo;

   void getProduct() async {
     emit(state.copyWith(status: FavoritesStatus.submitting));
     var result = await repo.getProducts();
    result.fold((failure) {
      emit(state.copyWith(failure: failure, status: FavoritesStatus.error));
    }, (model) {
      emit(state.copyWith(status: FavoritesStatus.success, model: model));
    });
  }
}
