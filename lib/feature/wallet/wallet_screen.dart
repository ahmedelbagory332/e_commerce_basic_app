import 'package:e_commerce_basic_app/core/constants.dart';
import 'package:e_commerce_basic_app/core/error_widget.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/manager/add_wallet_cubit.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/manager/add_wallet_state.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/view/add_wallet_screen.dart';
import 'package:e_commerce_basic_app/feature/notification/manager/notification_cubit.dart';
import 'package:e_commerce_basic_app/feature/notification/manager/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    BlocProvider.of<AddNewWalletCubit>(context).getUserCards();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Wallet'),
        actions:[
          IconButton(
              onPressed: (){
                PersistentNavBarNavigator
                    .pushNewScreen(
                  context,
                  screen: const AddWalletScreen(),
                  withNavBar: false,
                  pageTransitionAnimation:
                  PageTransitionAnimation
                      .cupertino,
                );
              }, icon: const Icon(Icons.add)),
        ] ,
        backgroundColor: kMainColor,
      ),
      body: BlocConsumer<AddNewWalletCubit, AddWalletState>(
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.cardsStatus) {
              case CardsStatus.success:
                {
                  return Visibility(
                    visible: state.cards.isNotEmpty,
                    replacement: const Center(
                      child:Text("You haven't any wallets"),
                    ),
                    child: ListView.builder(
                      itemCount: state.cards.length,
                      itemBuilder: (BuildContext context, int index) {
                        final card = state.cards[index];
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.wallet),
                            title: Text(card.cardName ?? ""),
                            subtitle: Text(BlocProvider.of<AddNewWalletCubit>(context).maskCreditCard(card.cardNumber ?? "")),
                            trailing:  InkWell(
                              onTap: (){
                                BlocProvider.of<AddNewWalletCubit>(context).deleteCard(card);
                              }, child: const Icon(Icons.delete)),
                          ),
                        );
                      },
                    ),
                  );
                }
                break;

              case CardsStatus.error:
                {
                  return WidgetError(
                    refresh: () {
                      BlocProvider.of<NotificationCubit>(context)
                          .getNotifications();
                    },
                    subTitle: state.failure.errMessage,
                  );
                }
                break;

              case CardsStatus.submitting:
                {
                  return const Center(child: CircularProgressIndicator());
                }
                break;

              case CardsStatus.initial:
                {
                  return const SizedBox();
                }
                break;
            }
          }),
    );
  }
}
