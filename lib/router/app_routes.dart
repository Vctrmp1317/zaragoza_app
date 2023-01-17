import 'package:flutter/material.dart';

import '../models/menu_option.dart';
import '../screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'login2';

  static final menuOptions = <MenuOption>[
    MenuOption(
        route: 'login2',
        name: 'Login Screen',
        screen: const Login2Screen(),
        icon: Icons.account_balance_outlined),
    MenuOption(
        route: 'registro',
        name: 'Registro Screen',
        screen: const RegisterScreen(),
        icon: Icons.account_balance_outlined),
    MenuOption(
        route: 'tienda',
        name: 'Shop Screen',
        screen: const ShopScreen(),
        icon: Icons.account_balance_outlined),
    MenuOption(
        route: 'addproduct',
        name: 'Add Porduct Screen',
        screen: const AddProductScreen(),
        icon: Icons.account_balance_outlined),
    MenuOption(
        route: 'userscreen',
        name: 'User Screen',
        screen: const UserScreen(),
        icon: Icons.account_balance_outlined),
    MenuOption(
        route: 'searchscreen',
        name: 'Search Screen',
        screen: const SearchScreen(),
        icon: Icons.account_balance_outlined),
    MenuOption(
        route: 'shoppingcartscreen',
        name: 'Shopping Cart Screen',
        screen: const ShoppingCartScreen(),
        icon: Icons.account_balance_outlined),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    for (final options in menuOptions) {
      appRoutes
          .addAll({options.route: (BuildContext context) => options.screen});
    }

    return appRoutes;
  }

  //static Map<String, Widget Function(BuildContext)> routes = {
  // 'home': (BuildContext context) => const HomeScreen(),
  //'listview1': (BuildContext context) => const Listview1Screen(),
  //'listview2': (BuildContext context) => const Listview2Screen(),
  //'alert': (BuildContext context) => const AlertScreen(),
  //'card': (BuildContext context) => const CardScreen(),
  // };

  static Route<dynamic> onGenerateRoute(settings) {
    return MaterialPageRoute(builder: (context) => const Login2Screen());
  }
}
