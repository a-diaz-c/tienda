import 'package:flutter/material.dart';
import 'package:tienda/src/routes/fluro.dart';
import 'package:fluro/fluro.dart' as fluro;

void main() {
  FluroRouter.setupRouter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final router = fluro.Router();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tienda app',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        //routes: getApplicationRouter(),
        onGenerateRoute: FluroRouter.router.generator);
  }
}
