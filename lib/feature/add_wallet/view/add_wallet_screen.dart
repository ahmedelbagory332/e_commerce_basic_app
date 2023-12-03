import 'package:e_commerce_basic_app/core/constants.dart';
import 'package:e_commerce_basic_app/core/custom_error_toast.dart';
import 'package:e_commerce_basic_app/core/custom_loading_dialog.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/data/model/card_model.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/manager/add_wallet_cubit.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/manager/add_wallet_state.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/view/components/card_alert_dialog.dart';
import 'package:e_commerce_basic_app/feature/home/view/components/add_wallet_widget.dart';
import 'package:e_commerce_basic_app/feature/home/view/home_screen.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class AddWalletScreen extends StatefulWidget {
  const AddWalletScreen({Key? key}) : super(key: key);

  @override
  State<AddWalletScreen> createState() => _AddWalletScreenState();
}

class _AddWalletScreenState extends State<AddWalletScreen> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController =
      TextEditingController();
  final TextEditingController cardExpiryDateController =
      TextEditingController();
  final TextEditingController cardCvvController = TextEditingController();

  final FlipCardController flipCardController = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AddNewWalletCubit, AddWalletState>(
          listener: (context, state) {
        switch (state.status) {
          case AddWalletStatus.success:
            {
              Navigator.of(context).pop();
              Future.delayed(const Duration(milliseconds: 300), () {
                showDialog(
                    context: context,
                     barrierDismissible: false,
                    builder: (context) =>  const CardAlertDialog());
                cardCvvController.clear();
                cardExpiryDateController.clear();
                cardHolderNameController.clear();
                cardNumberController.clear();
                flipCardController.toggleCard();
              });
            }
            break;

          case AddWalletStatus.error:
            {
              Navigator.of(context).pop();
              showCustomErrorToast(state.failure.errMessage);
            }
            break;

          case AddWalletStatus.submitting:
            {
              customLoadingDialog(context);
            }
            break;

          case AddWalletStatus.initial:
            {}
            break;
        }
      }, builder: (context, state) {
        return SafeArea(
          child: AddWalletWidget(
            saveCard: (cardCVV, cardDate, cardName, cardNumber) {
              if (cardNumber.length < 16 || isValidCardNumber(cardNumber.replaceAll(" ", ""))==false) {
                showCustomErrorToast("enter valid card number");
                return;
              }
              if (cardName.length < 4) {
                showCustomErrorToast("enter card holder name");
                return;
              }
              if (cardDate.length < 4) {
                showCustomErrorToast("enter card expire date");
                return;
              }
              if (cardCVV.length < 3) {
                showCustomErrorToast("enter card CVV");
                return;
              }

              context.read<AddNewWalletCubit>().saveCardInfo(
                  CardModel(cardName, cardNumber, cardCVV, cardDate));
            },
          ),
        );
      }),
    );
  }
}
