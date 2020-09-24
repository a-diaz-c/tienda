import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tienda/src/components/drawer.dart';
import 'package:tienda/src/components/footer.dart';
import 'package:tienda/src/components/navbar.dart';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:tienda/src/providers/productos_providers.dart';

class CarritoPage extends StatefulWidget {
  CarritoPage({Key key}) : super(key: key);

  @override
  _CarritoPageState createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  ScrollController _rrectController = ScrollController();
  ProductosProviders productosProviders = ProductosProviders();
  List datos = [];
  double subTotal;
  int cantidadProductos;

  @override
  void initState() {
    super.initState();
    _cargarCarrito();
  }

  _cargarCarrito() {
    datos = productosProviders.getProductosCarrito();
    if (datos == null) datos = [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        drawer: DrawerComponent(),
        body: DraggableScrollbar.rrect(
          alwaysVisibleScrollThumb: true,
          controller: _rrectController,
          backgroundColor: Colors.grey[300],
          child: ListView(
            controller: _rrectController,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Navbar(),
                  _cuerpo(),
                  footer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cuerpo() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titulo(),
          Container(
            child: Container(
              padding: EdgeInsets.only(right: 10.0),
              width: MediaQuery.of(context).size.width,
              height: 50 + (150 * datos.length).toDouble(),
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: ScrollPhysics(),
                children: [
                  DataTable(
                      columnSpacing: 100,
                      dataRowHeight: 150,
                      sortColumnIndex: 2,
                      sortAscending: false,
                      columns: [
                        DataColumn(label: Text("")),
                        DataColumn(label: Text("")),
                        DataColumn(label: Text("Producto")),
                        DataColumn(label: Text("Cantidad"), numeric: true),
                        DataColumn(
                            label: Text("Precion Unitario"), numeric: true),
                        DataColumn(label: Text("Total"), numeric: true),
                      ],
                      rows: rowProducto())
                ],
              ),
            ),
          ),
          _total(),
          _botonPago(),
        ],
      ),
    );
  }

  List<DataRow> rowProducto() {
    subTotal = 0;
    cantidadProductos = 0;
    List<DataRow> dataRow = [];
    datos.forEach(
      (element) {
        TextEditingController _myController = TextEditingController()
          ..text = element['cantidad'].toString();
        dataRow.add(
          DataRow(
            cells: [
              DataCell(
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    productosProviders.removeProductoCarrito(element['id']);
                    _cargarCarrito();
                    setState(() {});
                  },
                ),
              ),
              DataCell(
                Container(
                  width: 150,
                  child: Image(
                    image: NetworkImage(element['imagen']),
                  ),
                ),
              ),
              DataCell(Container(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(element['nombre'])],
                ),
              )),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (element['cantidad'] > 1) {
                        element['cantidad']--;
                      }

                      _myController.text = element['cantidad'].toString();
                      productosProviders.actualizarCarrito(datos);
                      setState(() {});
                    },
                  ),
                  Container(
                    width: 40,
                    height: 25,
                    child: TextField(
                      controller: _myController,
                      maxLength: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 5.0,
                        ),
                        counterText: '',
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (texto) {
                        setState(() {});
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      int cantidad = element['cantidad']++;

                      _myController.text = cantidad.toString();
                      productosProviders.actualizarCarrito(datos);
                      setState(() {});
                    },
                  ),
                ],
              )),
              DataCell(Text(element['precio'].toStringAsFixed(2))),
              DataCell(Text((element['precio'] * element['cantidad'])
                  .toStringAsFixed(2))),
            ],
          ),
        );
        subTotal += element['precio'] * element['cantidad'];
        cantidadProductos += element['cantidad'];
      },
    );
    return dataRow;
  }

  Widget _titulo() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        "Carrito",
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _total() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            "Total ($cantidadProductos Productos) ",
            style: TextStyle(fontSize: 18.0),
          ),
          Text(
            '\$' + subTotal.toStringAsFixed(2),
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _botonPago() {
    return Container(
      padding: EdgeInsets.all(10),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.black)),
        child: Text(
          "Proceder al pago",
          style: TextStyle(color: Colors.black, fontSize: 12.0),
        ),
        color: Colors.amber[400],
        onPressed: () {
          setState(() {
            Navigator.pushNamed(context, '/identificarse');
          });
        },
      ),
    );
  }
}
