import 'package:fluro/fluro.Dart' as fluro;
import 'package:flutter/material.Dart';
import 'package:tienda/src/pages/carrito_page.dart';
import 'package:tienda/src/pages/direcciones_page.dart';
import 'package:tienda/src/pages/familias_page.dart';
import 'package:tienda/src/pages/home_page.dart';
import 'package:tienda/src/pages/identificarse_page.dart';
import 'package:tienda/src/pages/pago_page.dart';
import 'package:tienda/src/pages/producto_page.dart';

class FluroRouter {
  static fluro.Router router = fluro.Router();
  static fluro.Handler _storyhandler = fluro.Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        ProductoPage(id: params['id'][0]),
  );
  static fluro.Handler _homehandler = fluro.Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        HomePage(),
  );
  static fluro.Handler _homehandlerProducto = fluro.Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        HomePage(
      familia: params['familia'][0],
    ),
  );
  static fluro.Handler _familiahandler = fluro.Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        FamiliaPage(
      familia: params['familia'][0],
    ),
  );
  static fluro.Handler _carritohandler = fluro.Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> parameters) =>
        CarritoPage(),
  );
  static fluro.Handler _pagohandler = fluro.Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> parameter) =>
        PagoPage(),
  );
  static fluro.Handler _indentificarsehandler = fluro.Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> parameter) =>
        IdentificarsePage(),
  );
  static fluro.Handler _direccioneshndler = fluro.Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> parameter) =>
        DireccionesPage(
      tipo: parameter['tipo'][0],
    ),
  );

  static void setupRouter() {
    router.define(
      '/',
      handler: _homehandler,
    );
    router.define(
      '/productos/:familia',
      handler: _homehandlerProducto,
    );
    router.define(
      '/producto/:id',
      handler: _storyhandler,
    );
    router.define(
      '/carrito',
      handler: _carritohandler,
    );
    router.define(
      '/pago',
      handler: _pagohandler,
    );
    router.define(
      '/identificarse',
      handler: _indentificarsehandler,
    );
    router.define(
      '/direcciones/:tipo',
      handler: _direccioneshndler,
    );
  }
}
