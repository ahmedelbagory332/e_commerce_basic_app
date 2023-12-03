import 'package:e_commerce_basic_app/core/constants.dart';
import 'package:e_commerce_basic_app/core/custom_error_toast.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/data/model/card_model.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/manager/add_wallet_cubit.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/manager/add_wallet_state.dart';
import 'package:e_commerce_basic_app/feature/cart/manager/cart_cubit.dart';
import 'package:e_commerce_basic_app/feature/cart/manager/cart_state.dart';
import 'package:e_commerce_basic_app/feature/home/view/components/add_wallet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../add_wallet/view/add_wallet_screen.dart';


class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {

  num selectedItemId = 0;
  @override
  void initState() {
    context.read<CartCubit>().getCart();
    context.read<AddNewWalletCubit>().getUserCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Check Out'),
          backgroundColor: kMainColor,
        ),
        bottomNavigationBar: InkWell(
          onTap: (){
            if(selectedItemId==0){
              showCustomErrorToast("please select wallet");
            }else{
              context.read<CartCubit>().emptyCart();
              Navigator.of(context).pop();
            }
          },
          child: Container(
            color: kMainColor,
            alignment: Alignment.center,
            height: 50.0,
            child: const Text(
              'Check Out',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Order Details',
                  style: TextStyle(color: kMainDarkColor,fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              BlocConsumer<CartCubit, CartState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    double cartCost = state.products!.fold(0, (previousValue, cartItem) {
                      return previousValue + (num.parse(cartItem.price??"") * int.parse(cartItem.quantity??""));
                    });
                  return  Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('Cart Items',style: TextStyle(color: kMainDarkColor),),
                          trailing: Text('${state.products.length}'),
                        ),
                        ListTile(
                          title: const Text('Cart Cost',style: TextStyle(color: kMainDarkColor)),
                          trailing: Text(r'$''$cartCost'),
                        ),
                        const ListTile(
                          title: Text('Fees',style: TextStyle(color: kMainDarkColor)),
                          trailing: Text(r'$''3'),
                        ),
                          ListTile(
                          title: const Text('Total Price',style: TextStyle(color: kMainDarkColor)),
                          trailing: Text(r'$''${cartCost + 3}'),
                        )
                      ],
                    ),
                  );
                }
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Divider(thickness: 2),
              ),
              const Card(
                child: ListTile(
                  title: Center(child: Text('your Address')),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Divider(thickness: 2),
              ),
              ListTile(
                title: const Text(
                  'Choose Wallet',
                  style: TextStyle(color: kMainDarkColor,fontSize: 20, fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.add),
                onTap: ()  {
                  PersistentNavBarNavigator
                      .pushNewScreen(
                    context,
                    screen: const AddWalletScreen(),
                    withNavBar: false,
                    pageTransitionAnimation:
                    PageTransitionAnimation
                        .cupertino,
                  );
                },
              ),
              BlocConsumer<AddNewWalletCubit, AddWalletState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                  return  Visibility(
                    visible: context.watch<AddNewWalletCubit>().state.cards.isNotEmpty,
                    replacement: const Center(
                      child:Text("You haven't any wallets"),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: context.watch<AddNewWalletCubit>().state.cards.length,
                      itemBuilder: (BuildContext context, int index) {
                        final card = context.watch<AddNewWalletCubit>().state.cards[index];
                        return Card(
                          child: RadioListTile<num>(
                            title: Text(card.cardName ?? ""),
                            subtitle: Text(BlocProvider.of<AddNewWalletCubit>(context).maskCreditCard(card.cardNumber ?? "")),
                            value: num.parse(card.cardNumber.replaceAll(" ", "")),
                            groupValue: selectedItemId,
                            onChanged: (value) {
                              setState(() {
                                selectedItemId = value!;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  );
                  }
              )
            ],
          ),
        ));
  }

}
