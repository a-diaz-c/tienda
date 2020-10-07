import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TiendaProviders {
  List<Map<String, String>> _listTiendas = [
    {'id': "1", "nombre": "Applebee's Cuernavaca"},
    {'id': "2", "nombre": "Applebee’s Plaza Carso"},
    {'id': "3", "nombre": "Applebee´s Galerías Saltillo"},
    {'id': "4", "nombre": "Applebee's Vía Vallejo"},
    {'id': "5", "nombre": "Applebee's Acapulco"}
  ];

  List getTiendas() {
    return _listTiendas;
  }

  addTienda(Map<String, dynamic> tienda) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tienda', jsonEncode(tienda));
  }

  Future<Map<String, dynamic>> getTienda() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tienda = prefs.getString('tienda');
    if (tienda != null) {
      return jsonDecode(tienda);
    }
    return {'id': '', 'nombre': 'Selecciona tu tienda'};
  }
}
