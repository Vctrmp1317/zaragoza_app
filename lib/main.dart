import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaragoza_app/providers/add_form_provider.dart';
import 'package:zaragoza_app/providers/login_form_provider.dart';
import 'package:zaragoza_app/providers/register_form_provider.dart';
import 'package:zaragoza_app/screens/screens.dart';

import 'providers/comment_form_provider.dart';
import 'providers/editComment_form_provider.dart';
import 'providers/edit_form_provider.dart';
import 'providers/update_form_provider.dart';
import 'router/app_routes.dart';
import 'services/services.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => LoginServices()),
      ChangeNotifierProvider(create: (_) => ArticulosServices()),
      ChangeNotifierProvider(create: (_) => CompraServices()),
      ChangeNotifierProvider(create: (_) => CarritoServices()),
      ChangeNotifierProvider(create: (_) => ArticuloService()),
      ChangeNotifierProvider(create: (_) => ArticulosGeneroServices()),
      ChangeNotifierProvider(create: (_) => ArticulosCompradosServices()),
      ChangeNotifierProvider(create: (_) => AddArticulosServices()),
      ChangeNotifierProvider(create: (_) => UserServices()),
      ChangeNotifierProvider(create: (_) => RegisterServices()),
      ChangeNotifierProvider(create: (_) => AddFormProvider()),
      ChangeNotifierProvider(create: (_) => UpdateFormProvider()),
      ChangeNotifierProvider(create: (_) => LoginFormProvider()),
      ChangeNotifierProvider(create: (_) => RegisterFormProvider()),
      ChangeNotifierProvider(create: (_) => CommentFormProvider()),
      ChangeNotifierProvider(create: (_) => EditFormProvider()),
      ChangeNotifierProvider(create: (_) => EditCommentFormProvider()),
    ], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dress Up Your Self',
      initialRoute: AppRoutes.initialRoute,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      routes: AppRoutes.getAppRoutes(),
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(245, 255, 253, 253)),
    );
  }
}
