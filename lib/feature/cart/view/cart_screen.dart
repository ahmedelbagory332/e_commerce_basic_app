import 'dart:ui';
import 'package:e_commerce_basic_app/core/error_widget.dart';
import 'package:e_commerce_basic_app/feature/cart/manager/cart_cubit.dart';
import 'package:e_commerce_basic_app/feature/cart/manager/cart_state.dart';
import 'package:e_commerce_basic_app/feature/cart/view/components/cart_item.dart';
import 'package:e_commerce_basic_app/feature/check_out/view/check_out_screen/check_out_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../core/constants.dart';
import 'components/reusable_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Cart'),
        backgroundColor: kMainColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<CartCubit, CartState>(
              listener: (context, state) {},
              builder: (context, state) {
                switch (state.status) {
                  case CartStatus.success:
                    {
                      return Visibility(
                          visible: state.products.isNotEmpty,
                          replacement: WidgetError(
                            refresh: () {
                              BlocProvider.of<CartCubit>(context).getCart();
                            },
                            subTitle: "Your Cart is Empty",
                            title: "",
                          ),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.products.length,
                              itemBuilder: (context, index) {
                                return cartItem(state, index, context);
                              }));
                    }
                    break;

                  case CartStatus.error:
                    {
                      return WidgetError(
                        refresh: () {
                          BlocProvider.of<CartCubit>(context).getCart();
                        },
                        subTitle: state.failure.errMessage,
                      );
                    }
                    break;

                  case CartStatus.submitting:
                    {
                      return const Center(child: CircularProgressIndicator());
                    }
                    break;

                  case CartStatus.initial:
                    {
                      return const SizedBox();
                    }
                    break;
                }
              },
            ),
          ),
          BlocConsumer<CartCubit, CartState>(
            listener: (context, state) {},
            builder: (context, state) {
              final ValueNotifier<num?> totalPrice = ValueNotifier(null);
              for (var element in state.products) {
                totalPrice.value =
                    (num.parse(element.price!) * int.parse(element.quantity!)) +
                        (totalPrice.value ?? 0);
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ValueListenableBuilder<num?>(
                        valueListenable: totalPrice,
                        builder: (context, val, child) {
                          return ReusableWidget(
                              title: 'Sub-Total',
                              value: r'$' + (val?.toStringAsFixed(2) ?? '0'));
                        }),
                  ],
                ),
              );
            },
          )
        ],
      ),
      bottomNavigationBar: context.watch<CartCubit>().state.products.isEmpty?const SizedBox():InkWell(
        onTap: () async {
          await PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const CheckOutScreen(),
            withNavBar: false,
            pageTransitionAnimation:
            PageTransitionAnimation
                .cupertino,
          );
         context.read<CartCubit>().getCart();
        },
        child: Container(
          color: kMainColor,
          alignment: Alignment.center,
          height: 50.0,
          child: const Text(
            'Proceed to Pay',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

}
