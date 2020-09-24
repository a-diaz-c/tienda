import 'package:flutter/material.dart';
import 'package:tienda/src/components/cardProductos.dart';
import 'package:tienda/src/components/contentDialogFiltro.dart';
import 'package:tienda/src/components/drawer.dart';
import 'package:tienda/src/components/footer.dart';
import 'package:tienda/src/components/navbar.dart';
import 'package:tienda/src/components/sideBar.dart';
import 'package:tienda/src/providers/productos_providers.dart';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';

class FamiliaPage extends StatefulWidget {
  String familia;
  FamiliaPage({Key key, this.familia}) : super(key: key);

  @override
  _FamiliaPageState createState() => _FamiliaPageState();
}

class _FamiliaPageState extends State<FamiliaPage> {
  List productos;
  List<String> marcas = [];
  List<bool> _checkbox;
  List<String> filtro = [];
  ProductosProviders providers = ProductosProviders();
  ScrollController _rrectController = ScrollController();
  @override
  void initState() {
    super.initState();
    _cargarProductos();
    _cargarMarcas();
    _checkbox = List.filled(marcas.length, false);
  }

  _cargarProductos() {
    var familia = widget.familia;

    productos = providers.buscarFamilia(familia);
  }

  _cargarMarcas() {
    productos.forEach((element) {
      if (marcas.indexOf(element['marca']) == -1) {
        marcas.add(element['marca']);
      }
    });
  }

  _actilizarProductos(String datos, bool value) {
    value ? filtro.add(datos) : filtro.remove(datos);
    print(filtro);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerComponent(),
      body: MediaQuery.of(context).size.width > 900 ? _escritrio() : _movil(),
    );
  }

  Widget _escritrio() {
    return DraggableScrollbar.rrect(
      alwaysVisibleScrollThumb: true,
      controller: _rrectController,
      backgroundColor: Colors.grey[300],
      child: ListView(
        controller: _rrectController,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Navbar(),
                productos.isEmpty ? _cuerpoVacio() : _cuerpo(),
                footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _movil() {
    return ListView(
      controller: _rrectController,
      children: [
        Navbar(),
        _cuerpo(),
        footer(),
      ],
    );
  }

  Widget _cuerpoVacio() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 20.0),
        width: MediaQuery.of(context).size.width * 0.50,
        height: MediaQuery.of(context).size.width * 0.80,
        child: Text(
          'No se encontro producto',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _cuerpo() {
    return LayoutBuilder(builder: (context, constraints) {
      print(MediaQuery.of(context).size.width);
      double ancho = MediaQuery.of(context).size.width;
      if (ancho > 1250) {
        double anchoContendorProductos =
            MediaQuery.of(context).size.width * 0.85;
        return Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _menuLateral(),
              Container(
                width: anchoContendorProductos,
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15.0),
                child: Column(
                  children: _mostrarProductos(anchoContendorProductos, 5),
                ),
              )
            ],
          ),
        );
      } else if (ancho > 825 && ancho <= 1250) {
        double anchoContendorProductos =
            MediaQuery.of(context).size.width * 0.85;
        print("500 - 1250");
        return Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _filtrosMovil(),
                    ..._mostrarProductos(anchoContendorProductos, 3)
                  ],
                ),
              )
            ],
          ),
        );
      } else if (ancho > 500 && ancho <= 825) {
        double anchoContendorProductos =
            MediaQuery.of(context).size.width * 0.85;
        print("500 - 825");
        return Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _filtrosMovil(),
                    ..._mostrarProductos(anchoContendorProductos, 2)
                  ],
                ),
              )
            ],
          ),
        );
      } else if (ancho <= 500) {
        double anchoContendorProductos =
            MediaQuery.of(context).size.width * 0.70;
        return Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    _filtrosMovil(),
                    ..._filaProductoExtraChica(anchoContendorProductos)
                  ],
                ),
              )
            ],
          ),
        );
      }
    });
  }

  List<Widget> _mostrarProductos(double ancho, int cantidadFila) {
    Map<int, int> maxNombre = {
      5: 75,
      3: 80,
      2: 100,
    };
    double anchoCard = ancho / cantidadFila;
    List<Widget> widgetProductos = [];
    List<Widget> row = [];
    for (int i = 0; i < productos.length; i++) {
      String nuevoNombre =
          _recortarTexto(productos[i]['nombre'], maxNombre[cantidadFila]);
      if ((i + 1) % cantidadFila == 0) {
        row.add(
          CardProducto(
            ancho: anchoCard,
            nombre: nuevoNombre,
            precio: double.parse(productos[i]['precio']),
            imagen: productos[i]['imagen'],
            id: productos[i]['clave_producto'],
          ),
        );
        widgetProductos.add(
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: row,
            ),
          ),
        );
        row = [];
      } else {
        row.add(
          CardProducto(
            ancho: anchoCard,
            nombre: nuevoNombre,
            precio: double.parse(productos[i]['precio']),
            imagen: productos[i]['imagen'],
            id: productos[i]['clave_producto'],
          ),
        );
      }
    }
    if (row.length != 0) {
      widgetProductos.add(
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: row,
          ),
        ),
      );
    }
    return widgetProductos;
  }

  List<Widget> _filaProductoExtraChica(double ancho) {
    List<Widget> widgetProductos = [];
    productos.forEach((element) {
      widgetProductos.add(Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardProducto(
              ancho: ancho,
              nombre: element['nombre'],
              precio: double.parse(element['precio']),
              imagen: element['imagen'],
              id: element['id'],
            ),
          ],
        ),
      ));
    });
    return widgetProductos;
  }

  String _recortarTexto(String texto, int maximo) {
    String nuevoTexto;
    if (texto.length > maximo) {
      nuevoTexto = texto.substring(0, maximo) + '...';
      return nuevoTexto;
    }
    return texto;
  }

  Widget _menuLateral() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Marcas",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          ..._crearElementos(),
          /*SizedBox(height: 10.0),
          InkWell(
            child: Text("Ver más..."),
            onTap: () {},
          )*/
        ],
      ),
    );
  }

  List<Widget> _crearElementos() {
    List<Widget> elementos = [];

    for (var i = 0; i < marcas.length; i++) {
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
                    value ? filtro.add(marcas[i]) : filtro.remove(marcas[i]);
                    if (filtro.length != 0) {
                      productos = providers.buscarPorMarcas(filtro);
                    } else {
                      productos = providers.buscarFamilia(widget.familia);
                    }
                    //print(productos);
                  });
                }),
            //InkWell(
            //child:
            Text(
              marcas[i],
              style: TextStyle(color: Colors.grey[800]),
            ),
            /*onTap: () {
                _checkbox[i] = _checkbox[i] == true ? false : true;

                setState(() {});
                print('value');
              },*/
            //)
          ],
        ),
      ));
    }

    return elementos;
  }

  Widget _filtrosMovil() {
    return RaisedButton(
      child: Row(
        children: [
          Icon(Icons.filter_list),
          Text('Filtros'),
        ],
      ),
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Buscar'),
              content: SingleChildScrollView(
                child: ContentDialog(
                  marcas: marcas,
                  parentAction: _actilizarProductos,
                  checkbox: _checkbox,
                ),
              ),
              actions: [
                FlatButton(
                  child: Text('Buscar'),
                  onPressed: () {
                    if (filtro.length != 0) {
                      productos = providers.buscarPorMarcas(filtro);
                    } else {
                      productos = providers.jsonProductos();
                    }
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
