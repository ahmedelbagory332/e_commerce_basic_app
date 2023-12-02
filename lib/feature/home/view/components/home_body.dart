import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_basic_app/core/custom_error_toast.dart';
import 'package:e_commerce_basic_app/core/custom_loading_dialog.dart';
import 'package:e_commerce_basic_app/core/error_widget.dart';
import 'package:e_commerce_basic_app/core/loading_widget.dart';
import 'package:e_commerce_basic_app/feature/details/details_screen.dart';
import 'package:e_commerce_basic_app/feature/home/manager/home_cubit.dart';
import 'package:e_commerce_basic_app/feature/home/manager/home_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'banner_image.dart';
import 'categorries.dart';
import 'item_card.dart';
import 'package:e_commerce_basic_app/core/constants.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Categories(),

        BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              switch (state.status) {
                case HomeStatus.initial:
                case HomeStatus.submitting:
                  {
                    return const LoadingWidget();
                  }
                  break;
                case HomeStatus.success:
                  {
                    return Visibility(
                      visible: context.read<HomeCubit>().state.model.isNotEmpty,
                      replacement: const Center(
                        child: Text("No Item Found"),
                      ),
                      child: Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("slider")
                                      .where('showAd', isEqualTo: true)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(child: CircularProgressIndicator());
                                    }
                                    if (snapshot.hasError) {
                                      return const SizedBox();
                                    }
                                    if (!snapshot.hasData) {
                                      return const SizedBox();
                                    }
                                    return SizedBox(
                                        height: 200,
                                        child: CarouselSlider(
                                          options: CarouselOptions(
                                              height: 400.0, autoPlay: true),
                                          items: snapshot.data!.docs.map((doc) {
                                            return Builder(builder: (BuildContext context) {
                                              return doc["showAd"] == true? BannerImage(imageUrl: doc["url"]):const SizedBox();
                                            },
                                            );
                                          }).toList(),
                                        ));
                                  }
                              ),
                              context.watch<HomeCubit>().state.productsStatus ==
                                  ProductsStatus.success
                                  ?
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kDefaultPaddin,
                                    vertical: kDefaultPaddin / 2),
                                child: GridView.count(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  children: List.generate(
                                    context.read<HomeCubit>().state.model.length,
                                        (int index) {
                                      return AnimationConfiguration.staggeredGrid(
                                        position: index,
                                        duration: const Duration(milliseconds: 800),
                                        columnCount: 2,
                                        child: ScaleAnimation(
                                          child: FadeInAnimation(
                                            child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: ItemCard(
                                                  product: context
                                                      .read<HomeCubit>()
                                                      .state
                                                      .model[index],
                                                  press: () =>
                                                      PersistentNavBarNavigator
                                                          .pushNewScreen(
                                                        context,
                                                        screen: DetailsScreen(
                                                          product: context
                                                              .read<HomeCubit>()
                                                              .state
                                                              .model[index],
                                                        ),
                                                        withNavBar: false,
                                                        pageTransitionAnimation:
                                                        PageTransitionAnimation
                                                            .cupertino,
                                                      )),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ) : Platform.isAndroid
                                  ? const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(child: CircularProgressIndicator()),
                                  )
                                  : const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(child: CupertinoActivityIndicator()),
                                  ),
                            ],
                          ),
                        ),
                      ),
                    );

                  }
                  break;
                case HomeStatus.error:
                  {
                    return WidgetError(
                      subTitle: state.failure.errMessage,
                      refresh: () {
                        context.read<HomeCubit>().getCategories();
                      },
                    );
                  }
              }
            }
        )
      ],
    );

  }

}
