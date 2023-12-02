import 'package:e_commerce_basic_app/core/constants.dart';
import 'package:e_commerce_basic_app/core/custom_error_toast.dart';
import 'package:e_commerce_basic_app/core/custom_loading_dialog.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/data/model/card_model.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/manager/add_wallet_cubit.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/manager/add_wallet_state.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/view/components/card_alert_dialog.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/view/components/card_input_formatter.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/view/components/card_month_input_formatter.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/view/components/master_card.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/view/components/my_painter.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    builder: (context) => const CardAlertDialog());
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                FlipCard(
                    fill: Fill.fillFront,
                    direction: FlipDirection.HORIZONTAL,
                    controller: flipCardController,
                    onFlip: () {},
                    flipOnTouch: false,
                    onFlipDone: (isFront) {},
                    front: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: buildCreditCard(
                        color: kDarkBlue,
                        cardExpiration: cardExpiryDateController.text.isEmpty
                            ? "MM/YYYY"
                            : cardExpiryDateController.text,
                        cardHolder: cardHolderNameController.text.isEmpty
                            ? "Card Holder"
                            : cardHolderNameController.text.toUpperCase(),
                        cardNumber: cardNumberController.text.isEmpty
                            ? "XXXX XXXX XXXX XXXX"
                            : cardNumberController.text,
                      ),
                    ),
                    back: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        elevation: 4.0,
                        color: kDarkBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Container(
                          height: 230,
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, bottom: 22.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(height: 0),
                              const Text(
                                'https://www.paypal.com',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 11,
                                ),
                              ),
                              Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width / 1.2,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              CustomPaint(
                                painter: MyPainter(),
                                child: SizedBox(
                                  height: 35,
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        cardCvvController.text.isEmpty
                                            ? "322"
                                            : cardCvvController.text,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 21,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 11,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                const SizedBox(height: 40),
                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width / 1.12,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: cardNumberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      hintText: 'Card Number',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.credit_card,
                        color: Colors.grey,
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                      CardInputFormatter(),
                    ],
                    onChanged: (value) {
                      var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                      setState(() {
                        cardNumberController.value = cardNumberController.value
                            .copyWith(
                                text: text,
                                selection: TextSelection.collapsed(
                                    offset: text.length),
                                composing: TextRange.empty);
                      });
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width / 1.12,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: cardHolderNameController,
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      hintText: 'Full Name',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        cardHolderNameController.value =
                            cardHolderNameController.value.copyWith(
                                text: value,
                                selection: TextSelection.collapsed(
                                    offset: value.length),
                                composing: TextRange.empty);
                      });
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width / 2.4,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: cardExpiryDateController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          hintText: 'MM/YY',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                          CardDateInputFormatter(),
                        ],
                        onChanged: (value) {
                          var text =
                              value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                          setState(() {
                            cardExpiryDateController.value =
                                cardExpiryDateController.value.copyWith(
                                    text: text,
                                    selection: TextSelection.collapsed(
                                        offset: text.length),
                                    composing: TextRange.empty);
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 14),
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width / 2.4,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: cardCvvController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          hintText: 'CVV',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        onTap: () {
                          setState(() {
                            Future.delayed(const Duration(milliseconds: 300),
                                () {
                              flipCardController.toggleCard();
                            });
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            int length = value.length;
                            if (length == 4 || length == 9 || length == 14) {
                              cardNumberController.text = '$value ';
                              cardNumberController.selection =
                                  TextSelection.fromPosition(
                                      TextPosition(offset: value.length + 1));
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20 * 3),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize:
                        Size(MediaQuery.of(context).size.width / 1.12, 55),
                  ),
                  onPressed: () {
                    if (cardNumberController.text.length < 16) {
                      showCustomErrorToast("enter complete card number");
                      return;
                    }
                    if (cardExpiryDateController.text.length < 4) {
                      showCustomErrorToast("enter card expire date");
                      return;
                    }
                    if (cardCvvController.text.length < 3) {
                      showCustomErrorToast("enter card CVV");
                      return;
                    }
                    if (cardHolderNameController.text.length < 4) {
                      showCustomErrorToast("enter card holder name");
                      return;
                    }
                    context.read<AddNewWalletCubit>().saveCardInfo(CardModel(
                        cardHolderNameController.text,
                        cardNumberController.text,
                        cardCvvController.text,
                        cardExpiryDateController.text));
                  },
                  child: Text(
                    'Add Card'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
