import 'package:flutter/material.dart';

class ContentDialog extends StatefulWidget {
  final void Function(String marca, bool value) parentAction;
  final List marcas;
  final List<bool> checkbox;

  ContentDialog(
      {Key key, @required this.marcas, this.parentAction, this.checkbox})
      : super(key: key);
  @override
  _ContentDialogState createState() => _ContentDialogState();
}

class _ContentDialogState extends State<ContentDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Marca'),
      children: _crearElementos(),
    );
  }

  List<Widget> _crearElementos() {
    List<Widget> elementos = [];

    for (var i = 0; i < widget.marcas.length; i++) {
      elementos.add(Container(
        padding: EdgeInsets.all(0),
        height: 25.0,
        child: Row(
          children: [
            Checkbox(
                value: widget.checkbox[i],
                onChanged: (bool value) {
                  setState(() {
                    widget.checkbox[i] = value;

                    widget.parentAction(widget.marcas[i], value);
                  });
                }),
            Text(
              widget.marcas[i],
              style: TextStyle(color: Colors.grey[800]),
            ),
          ],
        ),
      ));
    }

    return elementos;
  }
}
