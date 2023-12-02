import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_basic_app/core/failures.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/data/SecureStorage.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/data/model/card_model.dart';
import 'package:flutter/rendering.dart';
import 'add_wallet_state.dart';

class AddNewWalletCubit extends Cubit<AddWalletState> {
  AddNewWalletCubit() : super(AddWalletState.initial());

  final SecureStorage _secureStorage = SecureStorage();


  void saveCardInfo(CardModel newCard) async {
    emit(state.copyWith(status: AddWalletStatus.submitting));
    try{
       _secureStorage.readSecureData("card").then((value){

         if(value == null){

           List<CardModel> cards = [];
           cards.add(newCard);
           String jsonString = jsonEncode(cards.map((card) => card.toJson()).toList());
           _secureStorage.writeSecureData("card", jsonString);
           emit(state.copyWith(status: AddWalletStatus.success));

         }else{

           List<dynamic> parsedList = jsonDecode(value);
           List<CardModel> cards = parsedList.map((cardsJson) => CardModel.fromJson(cardsJson)).toList();

           if(cards.any((card) => card.cardNumber == newCard.cardNumber)){

             emit(state.copyWith(failure: ServerFailure("card already exists"), status: AddWalletStatus.error));

           }else{

             cards.add(newCard);
             String jsonString = jsonEncode(cards.map((card) => card.toJson()).toList());
             _secureStorage.writeSecureData("card", jsonString);
             emit(state.copyWith(status: AddWalletStatus.success));

           }
         }
       });

    }catch(e){
      emit(state.copyWith(failure: ServerFailure(e.toString()), status: AddWalletStatus.error));
    }


  }

  void deleteCard(CardModel oldCard) async {
    emit(state.copyWith(status: AddWalletStatus.submitting));
    try{
       _secureStorage.readSecureData("card").then((value){

         if(value != null){

           List<dynamic> parsedList = jsonDecode(value);
           List<CardModel> cards = parsedList.map((cardsJson) => CardModel.fromJson(cardsJson)).toList();
           cards.removeWhere((card) => card.cardNumber == oldCard.cardNumber);
           String jsonString = jsonEncode(cards.map((card) => card.toJson()).toList());
           _secureStorage.writeSecureData("card", jsonString);
           getUserCards();
         }else{
           emit(state.copyWith(failure: ServerFailure("e.toString()"), status: AddWalletStatus.error));

         }
       });

    }catch(e){
      emit(state.copyWith(failure: ServerFailure(e.toString()), status: AddWalletStatus.error));
    }


  }

  void getUserCards() async {
    emit(state.copyWith(cardsStatus: CardsStatus.submitting));
    try{
       _secureStorage.readSecureData("card").then((value){
         if(value == null){
           emit(state.copyWith(cards: [],cardsStatus: CardsStatus.success));
         }else{
           List<dynamic> parsedList = jsonDecode(value);
           List<CardModel> cards = parsedList.map((cardsJson) => CardModel.fromJson(cardsJson)).toList();

           emit(state.copyWith(cards: cards,cardsStatus: CardsStatus.success));
         }
       });

    }catch(e){
      emit(state.copyWith(failure: ServerFailure(e.toString()), cardsStatus: CardsStatus.error));
    }



  }

  String maskCreditCard(String cardNumber) {
    if (cardNumber.length < 4) {
      return cardNumber; // Not enough characters to mask
    }

    String masked = '';
    for (int i = 0; i < cardNumber.length - 4; i++) {
      if (cardNumber[i] != ' ') {
        masked += '*';
      } else {
        masked += ' ';
      }
    }

    return '$masked${cardNumber.substring(cardNumber.length - 4)}';
  }



}
