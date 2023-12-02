import 'package:e_commerce_basic_app/core/constants.dart';
import 'package:e_commerce_basic_app/core/error_widget.dart';
import 'package:e_commerce_basic_app/feature/favorites/manager/favorites_cubit.dart';
import 'package:e_commerce_basic_app/feature/favorites/manager/favorites_state.dart';
import 'package:e_commerce_basic_app/feature/notification/manager/notification_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../details/details_screen.dart';
import '../../home/view/components/item_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    BlocProvider.of<FavoritesCubit>(context).getProduct();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: kMainColor,
      ),
      body: BlocConsumer<FavoritesCubit, FavoritesState>(
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.status) {
              case FavoritesStatus.success:
                {
                  return Visibility(
                    visible: context.read<FavoritesCubit>().state.model.isNotEmpty,
                    replacement: const Center(
                      child: Text("No Item Found"),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPaddin,
                          vertical: kDefaultPaddin / 2),
                      child: GridView.count(
                         shrinkWrap: true,
                        crossAxisCount: 2,
                        children: List.generate(
                          context.read<FavoritesCubit>().state.model.length,
                              (int index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 300),
                              columnCount: 2,
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: ItemCard(
                                        product: context
                                            .read<FavoritesCubit>()
                                            .state
                                            .model[index],
                                        press: () =>
                                            PersistentNavBarNavigator
                                                .pushNewScreen(
                                              context,
                                              screen: DetailsScreen(
                                                product: context
                                                    .read<FavoritesCubit>()
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
                    ),
                  );
                }
                break;
              case FavoritesStatus.error:
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
              case FavoritesStatus.submitting:
                {
                  return const Center(child: CircularProgressIndicator());
                }
                break;
              case FavoritesStatus.initial:
                {
                  return const SizedBox();
                }
                break;
            }
          }),
    );
  }
}
