import 'package:flutter/material.dart';
import 'package:tienda/src/pages/carrito_page.dart';
import 'package:tienda/src/pages/home_page.dart';
import 'package:tienda/src/pages/producto_page.dart';

Map<String, WidgetBuilder> getApplicationRouter() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    '/producto': (BuildContext context) => ProductoPage(),
    '/carrito': (BuildContext context) => CarritoPage(),
  };
}
