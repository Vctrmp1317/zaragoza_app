import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaragoza_app/providers/add_form_provider.dart';
import 'package:zaragoza_app/providers/login_form_provider.dart';
import 'package:zaragoza_app/screens/screens.dart';

import 'router/app_routes.dart';

void main() => runApp(const MyApp());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AddFormProvider()),
      ChangeNotifierProvider(create: (_) => LoginFormProvider()),
    ], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: AppRoutes.initialRoute,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      routes: AppRoutes.getAppRoutes(),
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(245, 255, 253, 253)),
    );
  }
}
