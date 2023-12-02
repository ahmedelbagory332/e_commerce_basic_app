import 'package:e_commerce_basic_app/feature/home/manager/home_cubit.dart';
import 'package:e_commerce_basic_app/feature/home/manager/home_state.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_basic_app/core/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state){},
        builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPaddin, vertical: kDefaultPaddin),
          child: SizedBox(
            height: 55,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.categories.length,
              itemBuilder: (context, index) => buildCategory(index,context),
            ),
          ),
        );
      }
    );
  }

  Widget buildCategory(int index,BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<HomeCubit>().changeSelectedCategoryIndex(index);
        context.read<HomeCubit>().getProductCategory(context.read<HomeCubit>().state.categories[index]);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin / 10),
        child: Container(
          width: MediaQuery.of(context).size.width*.3,
           decoration: BoxDecoration(
            color: context.watch<HomeCubit>().state.selectedCategoryIndex == index ? kMainDarkColor : kMainColor,
            borderRadius: const BorderRadius.all(Radius.circular(10),),
          ),
          child: Center(
            child: Text(context.read<HomeCubit>().state.categories[index],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
