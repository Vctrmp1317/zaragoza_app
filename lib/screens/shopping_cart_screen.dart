import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zaragoza_app/providers/add_form_provider.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingCartScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbar(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const SizedBox(height: 5),
                  const ProductsShoppingCartUser(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: 300,
                      height: 120,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            const BoxShadow(
                              color: Colors.black38,
                              blurRadius: 5,
                              offset: Offset(0, 0),
                            )
                          ]),
                      child: Column(
                        children: [
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text('Total en la cesta de compra: ',
                                  style: TextStyle(fontSize: 17)),
                              const Spacer(),
                              const Text('45€', style: TextStyle(fontSize: 17))
                            ],
                          ),
                          Container(
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              height: 1,
                              width: 300,
                              color: Colors.black54),
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text('Total ',
                                  style: TextStyle(fontSize: 17)),
                              const Spacer(),
                              const Text('45€', style: TextStyle(fontSize: 17))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          shadowColor: MaterialStateProperty.all(Colors.black),
                          side: MaterialStateProperty.all(
                              const BorderSide(color: Colors.black)),
                          elevation: MaterialStateProperty.all(10),
                          fixedSize:
                              MaterialStateProperty.all(const Size(300, 50)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'orderscreen');
                      },
                      child: const Text('Tramitar Compra',
                          style: TextStyle(fontSize: 18, color: Colors.black)))
                ],
              )
            ],
          ),
        ));
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: Row(
        children: [
          const Text('Carrito',
              style: TextStyle(color: Colors.white, fontSize: 25)),
          const Spacer(),
          const SizedBox(width: 8),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'userscreen', (route) => false);
              },
              icon: const Icon(Icons.logout),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class _dividerLine extends StatelessWidget {
  const _dividerLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.black,
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.centerLeft,
                  colors: [Colors.black, Colors.black38])),
          height: 1,
          width: 130,
          margin: const EdgeInsets.only(left: 20, bottom: 5, top: 5),
        ),
        Container(
          decoration: const BoxDecoration(
              color: Colors.black,
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.centerRight,
                  colors: [Colors.black, Colors.black38])),
          height: 1,
          width: 180,
          margin: const EdgeInsets.only(right: 20, bottom: 5, top: 5),
        ),
      ],
    );
  }
}

// ignore: camel_case_types
class _searchBar extends StatefulWidget {
  const _searchBar({super.key});

  @override
  State<_searchBar> createState() => __searchBarState();
}

// ignore: camel_case_types
class __searchBarState extends State<_searchBar> {
  void updateList(String value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(
        top: 20,
      ),
      height: 30,
      width: 200,
      child: TextField(
        onSubmitted: (value) =>
            Navigator.pushReplacementNamed(context, 'userscreen'),
        textInputAction: TextInputAction.search,
        onChanged: ((value) => updateList(value)),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          focusColor: Colors.black87,
          border: InputBorder.none,
          hintText: "Buscar",
        ),
      ),
    );
  }
}

class ProductsShoppingCartUser extends StatefulWidget {
  const ProductsShoppingCartUser({super.key});

  @override
  State<ProductsShoppingCartUser> createState() =>
      _ProductsShoppingCartUserState();
}

class _ProductsShoppingCartUserState extends State<ProductsShoppingCartUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10),
        height: 350,
        width: 400,
        child: ListView.builder(
          itemBuilder: ((context, index) => const CardShoppingCart()),
          itemCount: 6,
        ));
  }
}

class CardShoppingCart extends StatelessWidget {
  const CardShoppingCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 10,
        height: 120,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                color: Colors.black38,
                blurRadius: 5,
                offset: Offset(0, 0),
              )
            ]),
        child: Column(
          children: [
            Row(
              children: [
                Positioned(
                  left: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.yellow,
                    ),
                    width: 100,
                    height: 100,
                    // ignore: prefer_const_literals_to_create_immutables
                    child: const ClipRRect(
                      child: FadeInImage(
                        placeholder: AssetImage('assets/no-image.jpg'),
                        image: AssetImage('assets/no-image.jpg'),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    width: 1,
                    height: 100,
                    color: Colors.black),
                Container(
                  margin: const EdgeInsets.only(top: 0),
                  height: 100,
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        'Descripcion',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        '45€',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Text(
                        'Talla XXL',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
