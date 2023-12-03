

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_basic_app/feature/cart/data/model/cart_model.dart';
import 'package:e_commerce_basic_app/feature/cart/manager/cart_cubit.dart';
import 'package:e_commerce_basic_app/feature/cart/manager/cart_state.dart';
import 'package:e_commerce_basic_app/feature/cart/view/components/plus_minus_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Card cartItem(CartState state, int index, BuildContext context) {
  return Card(
    elevation: 5.0,
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          CachedNetworkImage(
            height: 80,
            width: 80,
            placeholder: (context, url) => Image.asset(
              "assets/images/place_holder.jpg",
              fit: BoxFit.fill,
            ),
            imageUrl: state.products[index].image ?? "",
            errorWidget: (context, url, error) => Image.asset(
              "assets/images/place_holder.jpg",
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5.0,
                ),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  text: TextSpan(
                      text: 'Name: ',
                      style: TextStyle(
                          color: Colors.blueGrey.shade800, fontSize: 16.0),
                      children: [
                        TextSpan(
                            text: '${state.products[index].title!}\n',
                            style:
                            const TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                ),
                RichText(
                  maxLines: 1,
                  text: TextSpan(
                      text: 'Category: ',
                      style: TextStyle(
                          color: Colors.blueGrey.shade800, fontSize: 16.0),
                      children: [
                        TextSpan(
                            text: '${state.products[index].category!}\n',
                            style:
                            const TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                ),
                RichText(
                  maxLines: 1,
                  text: TextSpan(
                      text: 'Price: ' r"$",
                      style: TextStyle(
                          color: Colors.blueGrey.shade800, fontSize: 16.0),
                      children: [
                        TextSpan(
                            text: '${state.products[index].price!}\n',
                            style:
                            const TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                ),
              ],
            ),
          ),
          PlusMinusButtons(
            addQuantity: () {
              context.read<CartCubit>().addQuantity(CartModel(
                  id: state.products[index].id,
                  title: state.products[index].title,
                  price: state.products[index].price,
                  category: state.products[index].category,
                  quantity: state.products[index].quantity!,
                  image: state.products[index].image));
            },
            deleteQuantity: () {
              context.read<CartCubit>().deleteQuantity(CartModel(
                  id: state.products[index].id,
                  title: state.products[index].title,
                  price: state.products[index].price,
                  category: state.products[index].category,
                  quantity: state.products[index].quantity!,
                  image: state.products[index].image));
            },
            text: state.products[index].quantity.toString(),
          ),
          IconButton(
              onPressed: () {
                context
                    .read<CartCubit>()
                    .removeProduct(state.products[index].id!);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red.shade800,
              )),
        ],
      ),
    ),
  );
}
