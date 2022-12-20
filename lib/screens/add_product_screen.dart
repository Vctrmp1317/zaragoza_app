import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zaragoza_app/providers/add_form_provider.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      const backGroundAuth(),
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 52),
            const _appBar(),
            const _dividerLine(),
            const SizedBox(height: 80),
            ChangeNotifierProvider(
              create: (_) => AddFormProvider(),
              child: _AddForm(),
            ),
          ],
        ),
      ),
    ]));
  }
}

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
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.centerLeft,
                  colors: [Colors.white, Colors.white38])),
          height: 1,
          width: 130,
          margin: const EdgeInsets.only(left: 20, bottom: 5, top: 5),
        ),
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.centerRight,
                  colors: [Colors.white, Colors.white38])),
          height: 1,
          width: 180,
          margin: const EdgeInsets.only(right: 20, bottom: 5, top: 5),
        ),
      ],
    );
  }
}

class _appBar extends StatelessWidget {
  const _appBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const Text('Añadir Producto',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const Spacer(),
              const SizedBox(width: 8),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'tienda', (route) => false);
                  },
                  icon: const Icon(Icons.logout, color: Colors.white)),
            ],
          )),
    );
  }
}

class _classBar extends StatefulWidget {
  const _classBar({super.key});

  @override
  State<_classBar> createState() => __classBarState();
}

class __classBarState extends State<_classBar> {
  void updateList(String value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin:
              const EdgeInsetsDirectional.only(start: 20, top: 10, bottom: 10),
          height: 40,
          width: 250,
          child: TextField(
            onChanged: ((value) => updateList(value)),
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.search),
              focusColor: Colors.black87,
              border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.black)),
              hintText: "Search",
            ),
          ),
        ),
        const Spacer(),
        Container(
            margin: const EdgeInsets.only(right: 20),
            child:
                IconButton(onPressed: () {}, icon: const Icon(Icons.checkroom)))
      ],
    );
  }
}

class backGroundAuth extends StatelessWidget {
  const backGroundAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blueAccent[100],
      ),
      const _ColorBox()
    ]);
  }
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000,
      height: 1000,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black, blurRadius: 10),
          BoxShadow(color: Colors.white, blurRadius: 30)
        ],
        borderRadius: BorderRadius.circular(500),
        color: Colors.white,
      ),
    );
  }
}

class _Bub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 10)],
        gradient: LinearGradient(colors: [Colors.white70, Colors.white]),
        color: Colors.white,
      ),
    );
  }
}

BoxDecoration _buildBoxDecoration() {
  return const BoxDecoration(
    gradient: LinearGradient(colors: [Colors.black87, Colors.black38]),
  );
}

class _ColorBox extends StatelessWidget {
  const _ColorBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(top: 150, right: -50, child: _Bubble()),
            Positioned(top: 150, right: 30, child: _Bub()),
            Positioned(top: 250, right: 3, child: _Bub()),
            Positioned(top: 120, left: 160, child: _Bub()),
            Positioned(top: 300, left: 160, child: _Bub()),
          ],
        ));
  }
}

class _AddForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addForm = Provider.of<AddFormProvider>(context);
    const List<String> list = <String>['S', 'M', 'L', 'XL', 'XXL'];
    String dropdownValue = list.first;

    return Container(
      margin: const EdgeInsets.all(30),
      padding: EdgeInsets.all(10),
      width: 250,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 3)]),
      child: Form(
          key: addForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    focusColor: Colors.black,
                    hintText: 'Tipo de prenda',
                    labelText: 'Tipo',
                    suffixIcon: Icon(Icons.checkroom),
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (value) => addForm.tipo = value,
                  validator: (value) {}),
              const SizedBox(height: 20),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                    focusColor: Colors.black,
                    hintText: 'Color de prenda',
                    labelText: 'Color',
                    border: UnderlineInputBorder(),
                    suffixIcon: Icon(Icons.color_lens)),
                onChanged: (value) => addForm.color = value,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                  icon: const Icon(Icons.accessibility_sharp),
                  value: dropdownValue,
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    addForm.talla = value!;
                    dropdownValue = value;
                  }),
              const SizedBox(height: 20),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                    focusColor: Colors.black,
                    hintText: 'Material de la prenda',
                    labelText: 'Material',
                    border: UnderlineInputBorder(),
                    suffixIcon: Icon(Icons.style)),
                onChanged: (value) => addForm.material = value,
              ),
              const SizedBox(height: 20),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    focusColor: Colors.black,
                    hintText: 'Precio de la prenda',
                    labelText: 'Precio',
                    border: UnderlineInputBorder(),
                    suffixIcon: Icon(Icons.attach_money)),
                onChanged: (value) => addForm.precio = value as int,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueAccent[100]),
                    fixedSize: MaterialStateProperty.all(
                        const Size(double.infinity, 30)),
                  ),
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (addForm.isValidForm()) {
                      //Navigator.pushNamed(context, 'edit');
                    }
                  },
                  // ignore: prefer_const_literals_to_create_immutables
                  child: Row(children: [
                    const Text(
                      'Guardar',
                      style: TextStyle(fontSize: 15),
                    ),
                    const Spacer(),
                    const Icon(Icons.save)
                  ]),
                ),
              ),
            ],
          )),
    );
  }
}
