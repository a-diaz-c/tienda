import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  String titulo;
  List contenido;

  SideBar({Key key, @required this.titulo, @required this.contenido})
      : super(key: key);
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  List<bool> _checkbox;

  @override
  void initState() {
    super.initState();
    _checkbox = List.filled(widget.contenido.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.titulo,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          ..._crearElementos(),
        ],
      ),
    );
  }

  List<Widget> _crearElementos() {
    List<Widget> elementos = [];

    for (var i = 0; i < widget.contenido.length; i++) {
      elementos.add(Container(
        padding: EdgeInsets.all(0),
        height: 25.0,
        child: Row(
          children: [
            Checkbox(
                value: _checkbox[i],
                onChanged: (bool value) {
                  setState(() {
                    _checkbox[i] = value;
                    print(value);
                  });
                }),
            Text(
              widget.contenido[i],
              style: TextStyle(color: Colors.grey[800]),
            ),
          ],
        ),
      ));
    }

    return elementos;
  }
}
