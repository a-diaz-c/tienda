import 'package:flutter/material.dart';

class DialogPregunta extends StatelessWidget {
  final String titulo;
  final String contenido;

  const DialogPregunta({Key key, this.titulo, this.contenido})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titulo),
      content: Text(contenido),
      actions: [
        FlatButton(
            child: Text('Si'),
            onPressed: () {
              Navigator.pushNamed(context, '/carrito');
            }),
        FlatButton(
            child: Text('No'), onPressed: () => Navigator.of(context).pop())
      ],
    );
  }
}
