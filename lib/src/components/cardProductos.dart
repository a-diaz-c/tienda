import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tienda/src/components/dialogPregunta.dart';
import 'package:tienda/src/providers/productos_providers.dart';

class CardProducto extends StatefulWidget {
  final void Function() parentAction;

  String imagen;
  String nombre;
  double precio;
  double ancho;
  String id;

  CardProducto({
    Key key,
    @required this.imagen,
    @required this.nombre,
    @required this.precio,
    @required this.id,
    this.ancho = 250,
    this.parentAction,
  });

  @override
  _CardProductoState createState() => _CardProductoState();
}

class _CardProductoState extends State<CardProducto> {
  int _conteo = 1;
  double _total = 0;
  TextEditingController _controller = TextEditingController()..text = "1";

  _CardProductoState({
    Key key,
  });

  @override
  Widget build(BuildContext context) {
    var clave = widget.id;
    return Container(
      width: widget.ancho - 10,
      height: widget.ancho * 1.2,
      padding: EdgeInsets.all(10.0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              child: _imagen(widget.ancho - 10),
              onTap: () {
                Navigator.pushNamed(context, 'producto/$clave');
              },
            ),
            InkWell(
              child: _nombre(),
              onTap: () {
                Navigator.pushNamed(context, 'producto/$clave');
              },
            ),
            _precio(),
            //_cantidad(),
            _botonAgregar(),
          ],
        ),
      ),
    );
  }

  Widget _imagen(double ancho) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Image(
            image: NetworkImage(widget.imagen),
            height: ancho * 0.50,
            width: ancho * 0.50,
          ),
        ),
      ],
    );
  }

  Widget _nombre() {
    String nuevonombre = _recortarTexto(widget.nombre);
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Text(
        nuevonombre,
        style:
            TextStyle(fontWeight: FontWeight.normal, color: Colors.blue[800]),
      ),
    );
  }

  Widget _precio() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('\$ ' + widget.precio.toString()),
      ],
    );
  }

  Widget _botonAgregar() {
    return Container(
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _inputCantidad(),
          SizedBox(width: 5.0),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.shopping_cart,
                  size: 14.0,
                ),
                Text(" Agregar", style: TextStyle(fontSize: 13.0)),
              ],
            ),
            onPressed: () {
              Map<String, dynamic> producto = {
                'id': widget.id,
                'nombre': widget.nombre,
                'precio': widget.precio,
                'imagen': widget.imagen,
                'cantidad': int.parse(_controller.text),
              };
              if (_controller.text != '0') {
                ProductosProviders providers = ProductosProviders();
                providers.addProductoCarrito(producto);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DialogPregunta(
                      titulo: 'Agregado al Carrito',
                      contenido: '¿Ir al carrito?',
                    );
                  },
                );
                widget.parentAction();
                //setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _inputCantidad() {
    return Container(
      width: 45.0,
      height: 35.0,
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: Colors.blueGrey,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              style: TextStyle(
                fontSize: 12.0,
              ),
              controller: _controller,
              keyboardType: TextInputType.numberWithOptions(
                decimal: false,
                signed: true,
              ),
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(0.0),
            height: 35.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: InkWell(
                    child: Icon(
                      Icons.arrow_drop_up,
                      size: 12.0,
                    ),
                    onTap: () {
                      int currentValue = int.parse(_controller.text);
                      setState(() {
                        currentValue++;
                        _controller.text =
                            (currentValue).toString(); // incrementing value
                      });
                    },
                  ),
                ),
                InkWell(
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: 12.0,
                  ),
                  onTap: () {
                    int currentValue = int.parse(_controller.text);
                    setState(() {
                      currentValue--;
                      _controller.text = (currentValue > 0 ? currentValue : 0)
                          .toString(); // decrementing value
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _recortarTexto(String texto) {
    String nuevoTexto;
    if (texto.length > 75) {
      nuevoTexto = texto.substring(0, 75) + '...';
      return nuevoTexto;
    }
    return texto;
  }
}
