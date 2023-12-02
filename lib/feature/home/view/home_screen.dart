
import 'package:e_commerce_basic_app/feature/home/view/components/home_body.dart';
import 'package:e_commerce_basic_app/feature/home/view/components/home_header.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children:  [
          HomeHeader(),
          Expanded(child: HomeBody()),
        ],
      ),
    );
  }

 }
