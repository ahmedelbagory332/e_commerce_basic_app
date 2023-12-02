

import 'package:e_commerce_basic_app/feature/home/data/model/products_model.dart';
import 'package:e_commerce_basic_app/feature/notification/data/sqlite/NotificationTable.dart';
import 'package:equatable/equatable.dart';

import '../../../core/failures.dart';
import '../data/model/card_model.dart';

enum AddWalletStatus { initial, submitting, success, error }
enum CardsStatus { initial, submitting, success, error }


class AddWalletState extends Equatable {
  final AddWalletStatus status;
  final CardsStatus cardsStatus;
  final List<CardModel> cards;
  final Failure failure;
 


  const AddWalletState({
    required this.status,
    required this.cardsStatus,
    required this.cards,
    required this.failure,
  });

  factory AddWalletState.initial() {
    return const AddWalletState(
      status: AddWalletStatus.initial,
        cardsStatus: CardsStatus.initial,
      cards: [],
      failure: Failure("")

    );
  }

  @override
  List<Object> get props => [status,cardsStatus,cards,failure];

  AddWalletState copyWith(
      {
        AddWalletStatus? status,
        Failure? failure,
        List<CardModel>? cards,
        CardsStatus? cardsStatus
      }) {
    return AddWalletState(
      status: status ?? this.status,
      cardsStatus: cardsStatus ?? this.cardsStatus,
      cards: cards ?? this.cards,
      failure: failure ?? this.failure,

    );
  }
}
