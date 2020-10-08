import 'package:flutter/material.dart';

Widget footer() {
  return LayoutBuilder(builder: (context, constraints) {
    double anchoPantalla = MediaQuery.of(context).size.width;
    if (anchoPantalla > 900) {
      return Container(
        padding: EdgeInsets.only(top: 20.0),
        color: Color(0xffd11507),
        child: Column(
          children: [
            _parteUno(context),
            SizedBox(height: 15),
            _parteTres(),
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(top: 20.0),
        color: Color(0xffd11507),
        child: Column(
          children: [
            _soporte(MainAxisAlignment.start, context),
            SizedBox(height: 10.0),
            _servicioCliente(),
            _parteTres(),
          ],
        ),
      );
    }
  });
}

Widget _parteUno(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image(image: AssetImage('images/logo.JPG')),
        _soporte(MainAxisAlignment.start, context),
        _servicioCliente(),
      ],
    ),
  );
}

Widget _soporte(MainAxisAlignment main, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5.0),
    child: Row(
      mainAxisAlignment: main,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Soporte",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.0),
            _textoSoporte("Secursales", context),
            SizedBox(height: 5.0),
            _textoSoporte("Tickets de Soporte", context),
            SizedBox(height: 5.0),
            _textoSoporte("Preguntas frecuentes", context),
            SizedBox(height: 5.0),
            _textoSoporte("Políticas de devoluciones", context)
          ],
        ),
      ],
    ),
  );
}

Widget _textoSoporte(String contenido, BuildContext context) {
  return InkWell(
    child: Text(
      contenido,
      style:
          TextStyle(decoration: TextDecoration.underline, color: Colors.white),
    ),
    onTap: () {
      Navigator.pushNamed(context, 'sucursales');
    },
  );
}

Widget _servicioCliente() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Servicio al cliente",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.white)),
          child: Row(
            children: [
              Icon(
                Icons.phone,
                color: Colors.white,
              ),
              Text(
                "(744) 484.9493",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          onPressed: () {},
          color: Color(0xffd11507),
        ),
        SelectableText(
          "info@kingo.com.mx",
          style: TextStyle(fontSize: 12.0, color: Colors.white),
        )
      ],
    ),
  );
}

Widget _parteTres() {
  return Container(
    padding: EdgeInsets.all(20.0),
    child: Text(
      "Copyright © 2020 Kingo Systems S.A. de C.V.",
      style: TextStyle(fontSize: 12.0, color: Colors.white),
    ),
  );
}
