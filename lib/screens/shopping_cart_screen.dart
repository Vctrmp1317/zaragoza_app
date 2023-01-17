import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zaragoza_app/providers/add_form_provider.dart';

final ttsShoppingCart = FlutterTts();
var _counter = 2;

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingCartScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    ttsShoppingCart.awaitSpeakCompletion(true);
    ttsShoppingCart.speak('Bienvenido al carrito de compra');
    return Scaffold(
        appBar: _appbar(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _dividerLine(),
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const SizedBox(height: 5),
                  const ProductsShoppingCartUser(),
                ],
              )
            ],
          ),
        ));
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          const _searchBar(),
          const Spacer(),
          Stack(children: [
            IconButton(
              color: Colors.black,
              icon: const Icon(Icons.shopping_bag),
              onPressed: () {},
            ),
            Positioned(
              child: Text('$_counter', style: TextStyle(color: Colors.black)),
            )
          ]),
          const SizedBox(width: 8),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: IconButton(
              color: Colors.black,
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
      height: 600,
      width: 400,
      child: GridView.builder(
        itemBuilder: ((context, index) => const CardShoppingCart()),
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 300, mainAxisSpacing: 0),
      ),
    );
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
        height: 220,
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
            Stack(children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                ),
                width: 300,
                height: 145,
                // ignore: prefer_const_literals_to_create_immutables
                child: Stack(children: [
                  const ClipRRect(
                    child: FadeInImage(
                      placeholder: AssetImage('assets/no-image.jpg'),
                      image: AssetImage('assets/no-image.jpg'),
                      width: 300,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ]),
              ),
            ]),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 50,
              width: 200,
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
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 1,
              color: Colors.black45,
              width: 200,
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 50,
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(
                            context, 'userscreen'),
                        child: const Text(
                          'Compra \n Rapida',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            _counter = _counter++;
                          },
                          icon: Icon(Icons.add_shopping_cart))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
