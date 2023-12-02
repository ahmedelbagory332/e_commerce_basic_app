import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_basic_app/feature/favorites/view/favorites_screen.dart';
import 'package:e_commerce_basic_app/feature/settings/view/settings.dart' as SettingTab;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:e_commerce_basic_app/core/constants.dart';
import '../home/view/home_screen.dart';


class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.

      ),
    );
  }

   List<Widget> _buildScreens() {
     return [
       const HomeScreen(),
       const HomeScreen(),
       const FavoritesScreen(),
       const SettingTab.Settings()
     ];
   }

   List<PersistentBottomNavBarItem> _navBarsItems() {
     return [
       PersistentBottomNavBarItem(
         icon: const Icon(CupertinoIcons.home),
         title: ("Home"),
         activeColorPrimary: kMainDarkColor,
         inactiveColorPrimary: Colors.grey,
       ),
       PersistentBottomNavBarItem(
         icon: const Icon(CupertinoIcons.cart),
         title: ("Cart"),
         activeColorPrimary: kMainDarkColor,
         inactiveColorPrimary: Colors.grey,
       ),
       PersistentBottomNavBarItem(
         icon: const Icon(CupertinoIcons.heart_solid),
         title: ("Favorites"),
         activeColorPrimary: kMainDarkColor,
         inactiveColorPrimary: Colors.grey,
       ),
       PersistentBottomNavBarItem(
         icon: const Icon(CupertinoIcons.settings),
         title: ("Settings"),
         activeColorPrimary: kMainDarkColor,
         inactiveColorPrimary: Colors.grey,
       ),
     ];
   }

 }
