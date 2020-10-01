import 'package:flutter/material.dart';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:tienda/src/components/drawer.dart';
import 'package:tienda/src/components/footer.dart';
import 'package:tienda/src/components/navbar.dart';
import 'package:tienda/src/providers/productos_providers.dart';

class PagoPage extends StatefulWidget {
  @override
  _PagoPageState createState() => _PagoPageState();
}

class _PagoPageState extends State<PagoPage>
    with SingleTickerProviderStateMixin {
  ScrollController _rrectController = ScrollController();
  TabController _tabController;
  ProductosProviders productosProviders = ProductosProviders();
  double _subTotal = 0;
  double _costoEnvio = 0;
  double _total;
  double _ancho;
  bool _paypal = true;
  bool _tarjeta = false;
  bool _efectivo = false;
  bool _envioDomicilio = true;
  bool _recogerTienda = false;
  bool _factura = false;
  List datos = [];

  Map<String, dynamic> envio = {
    'nombre': 'Hector',
    'apellidos': 'Nunez',
    'empresa': 'Kingo System',
    'sexo': 'H',
    'telefono': '7444849493',
    'calle': 'Av. Costera Miguel Aleman',
    'numExt': '1252',
    'numInt': '18',
    'referencia': 'En la torre de Acapulco',
    'colonia': 'Club Deportivo',
    'codigoPostal': '39690',
    'ciudad': 'Acapulco',
    'estado': 'Guerrero',
    'pais': 'México',
  };

  Map<String, dynamic> datosRecoger = {
    'nombre': 'Hector',
    'apellidos': 'Nunez',
    'telefono': '7444849493',
  };

  Map<String, dynamic> factura = {
    'nombre': 'Kingo Systems SA de CV',
    'rfc': 'KYS010331243',
    'email': '',
    'usoDeCEDI': 'G03 - Gastos en general',
  };

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _cargarCarrito();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  _cargarCarrito() {
    datos = productosProviders.getProductosCarrito();
    if (datos == null) datos = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerComponent(),
      body: DraggableScrollbar.rrect(
        alwaysVisibleScrollThumb: true,
        controller: _rrectController,
        backgroundColor: Colors.grey[300],
        child: ListView(
          controller: _rrectController,
          children: [
            Navbar(),
            if (MediaQuery.of(context).size.width > 900)
              _cuerpoWeb()
            else ...[_cuerpoMovil(), _tablaProductos()],
            _cardFactura(MediaQuery.of(context).size.width * 0.40),
            _botonContinuar(),
            footer(),
          ],
        ),
      ),
    );
  }

  Widget _cuerpoWeb() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //_tabs(MediaQuery.of(context).size.width * 0.65),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _envioDomicilio,
                      onChanged: (bool value) {
                        setState(() {
                          _envioDomicilio = value;
                          _recogerTienda = false;
                        });
                      },
                    ),
                    Text('Enviar'),
                    SizedBox(width: 10.0),
                    Checkbox(
                      value: _recogerTienda,
                      onChanged: (bool value) {
                        setState(() {
                          _recogerTienda = value;
                          _envioDomicilio = false;
                        });
                      },
                    ),
                    Text('Recoger en tienda'),
                  ],
                ),
                _recogerTienda ? _cardRecogerTienda() : _cardEnvioDomicilio(),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _paypal,
                      onChanged: (bool value) {
                        setState(() {
                          _paypal = value;
                          _tarjeta = false;
                          _efectivo = false;
                        });
                      },
                    ),
                    Text('Paypa'),
                    SizedBox(width: 10.0),
                    Checkbox(
                      value: _tarjeta,
                      onChanged: (bool value) {
                        setState(() {
                          _tarjeta = value;
                          _paypal = false;
                          _efectivo = false;
                        });
                      },
                    ),
                    Text('Tarjeta de credito/dibito'),
                    SizedBox(width: 10.0),
                    Checkbox(
                      value: _efectivo,
                      onChanged: (bool value) {
                        setState(() {
                          _efectivo = value;
                          _paypal = false;
                          _tarjeta = false;
                        });
                      },
                    ),
                    Text('Efectivo'),
                  ],
                ),
                _mostrarMetodoPago(),
              ],
            ),
          ),
        ),
        _tablaProductos(),
      ],
    );
  }

  Widget _cuerpoMovil() {
    return _tabs(MediaQuery.of(context).size.width * 0.95);
  }

  Widget _tabs(double ancho) {
    return Center(
      child: Container(
        width: ancho,
        padding: EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 40.0,
              child: TabBar(
                tabs: [
                  Tab(
                    child: Container(
                      height: 25,
                      child: Text(
                        "Elegir Dirección",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      height: 25,
                      child: Text(
                        "Envio y Pago",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
                controller: _tabController,
                indicatorColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
            Center(
              child: [
                _direcciones(MediaQuery.of(context).size.width > 900
                    ? ancho * 0.70
                    : ancho),
                _envioPago(ancho)
              ][_tabController.index],
            ),
          ],
        ),
      ),
    );
  }

  Widget _tablaProductos() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.30,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Card(
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Carito de compras',
                style: TextStyle(fontSize: 15),
              ),
            ),
            const Divider(
              color: Colors.black,
              height: 1,
              thickness: 1,
            ),
            ..._productos(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Subtotal \$ ' + _subTotal.toStringAsFixed(2)),
                Text('Costo de envío \$ ' + _costoEnvio.toStringAsFixed(2)),
                const Divider(
                  color: Colors.black,
                  height: 1,
                  thickness: 1,
                ),
                Text('Precio total \$ ' + _total.toStringAsFixed(2)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _direcciones(double ancho) {
    return Column(
      children: [
        Container(
          height: 100,
          child: Card(
            child: Row(
              children: [
                Checkbox(
                  value: _envioDomicilio,
                  onChanged: (bool value) {
                    setState(() {
                      _envioDomicilio = value;
                      _recogerTienda = false;
                    });
                  },
                ),
                Expanded(child: Text('Enviar')),
                SizedBox(width: 10.0),
                Checkbox(
                  value: _recogerTienda,
                  onChanged: (bool value) {
                    setState(() {
                      _recogerTienda = value;
                      _envioDomicilio = false;
                    });
                  },
                ),
                Expanded(child: Text('Recoger en tienda')),
              ],
            ),
          ),
        ),
        _recogerTienda ? _cardRecogerTienda() : _cardEnvioDomicilio(),
        Container(
          height: 100,
          child: Card(
            child: Row(
              children: [
                Checkbox(
                  value: _factura,
                  onChanged: (bool value) {
                    setState(() {
                      _factura = value;
                    });
                  },
                ),
                Expanded(child: Text('Factura')),
              ],
            ),
          ),
        ),
        Card(
          child: Opacity(
            opacity: _factura ? 1 : 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Text(
                    'Direccion de facturacion',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Text('Verifique sus de facturacion'),
                ),
                if (MediaQuery.of(context).size.width > 900)
                  _direccionFacturaWeb(ancho)
                else
                  ..._direccionFacturaMovil(ancho),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _cardEnvioDomicilio() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Direccion de envio',
            style: TextStyle(fontSize: 20),
          ),
          Text(envio['nombre'] + ' ' + envio['apellidos']),
          Text(envio['empresa']),
          Text(envio['calle'] + ' ' + envio['numExt'] + ' ' + envio['numInt']),
          Text(envio['referencia']),
          Text(envio['colonia']),
          Text(envio['codigoPostal'] + ', ' + envio['ciudad']),
          Text(envio['estado'] + ', ' + envio['pais']),
          SizedBox(height: 5),
          Text('Tel, ' + envio['telefono']),
          InkWell(
            child: Text(
              'Cambiar',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }

  Widget _cardRecogerTienda() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Datos de entrega',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            'Nombre, ' + datosRecoger['nombre'],
            style: TextStyle(fontSize: 15),
          ),
          Text('Apellido, ' + datosRecoger['apellidos'],
              style: TextStyle(fontSize: 15)),
          Text('Tel, ' + datosRecoger['telefono'],
              style: TextStyle(fontSize: 15)),
          InkWell(
            child: Text(
              'Cambiar',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }

  Widget _mostrarMetodoPago() {
    if (_paypal) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Paypal'),
            Text('email'),
            InkWell(
              child: Text(
                'Cambiar',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {},
            )
          ],
        ),
      );
    } else if (_tarjeta) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Tarjeta'),
            Text('Nombre'),
            InkWell(
              child: Text(
                'Cambiar',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {},
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Pago al recibir el pedido'),
          ],
        ),
      );
    }
  }

  Widget _direccionFacturaWeb(double ancho) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _cardFactura(ancho),
      ],
    );
  }

  List<Widget> _direccionFacturaMovil(double ancho) {
    return [
      _cardFactura(ancho),
      _botonEditar('direcciones/2', _factura),
    ];
  }

  Widget _cardFactura(double ancho) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 500,
                  child: Row(
                    children: [
                      Checkbox(
                        value: _factura,
                        onChanged: (bool value) {
                          setState(() {
                            _factura = value;
                          });
                        },
                      ),
                      Text('Factura'),
                    ],
                  ),
                ),
                Opacity(
                  opacity: _factura ? 1 : 0.3,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.30,
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Razon social o nombre',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Text(factura['nombre']),
                        SizedBox(height: 5),
                        Text(
                          'RFC',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Text(factura['rfc']),
                        SizedBox(height: 5),
                        Text(
                          'Uso de CFDI',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Text(factura['usoDeCEDI']),
                        InkWell(
                          child: Text(
                            'Cambiar',
                            style: TextStyle(color: Colors.blue),
                          ),
                          onTap: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _botonContinuar() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: RaisedButton(
            child: Text(
              "Continuar",
              style: TextStyle(),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.blue,
            onPressed: () {
              if (_tabController.index < _tabController.length - 1) {
                _tabController.animateTo(_tabController.index + 1);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _botonEditar(String ruta, bool activo) {
    return Container(
      width: 160,
      child: RaisedButton(
        child: Row(
          children: [
            Icon(Icons.edit),
            Text('Editar Direccion'),
          ],
        ),
        onPressed: () {
          if (activo) Navigator.pushNamed(context, ruta);
        },
      ),
    );
  }

  List<Widget> _productos() {
    _subTotal = 0;
    List<Widget> lista = [];
    datos.forEach((element) {
      _subTotal += element['precio'] * element['cantidad'];
      lista.add(
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
          child: Text(
            element['nombre'],
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ),
      );
    });
    _total = _subTotal + _costoEnvio;
    return lista;
  }

  Widget _envioPago(double ancho) {
    return Column(
      children: [
        _opcionesPago(ancho),
      ],
    );
  }

  Widget _opcionesPago(double ancho) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Text(
              'Forma de envío',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            height: 125,
            width: ancho,
            child: Card(
              color: Colors.grey[300],
              child: Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _paypal,
                        onChanged: (bool value) {
                          setState(() {
                            _paypal = value;
                            _tarjeta = false;
                            _efectivo = false;
                          });
                        },
                      ),
                      Text('Paypal')
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                          image: AssetImage('images/paypal.png'),
                          height: 50,
                        ),
                        if (MediaQuery.of(context).size.width > 900)
                          Image(
                            image: AssetImage('images/paypal_tarjetas.png'),
                            height: 60,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 125,
            width: ancho,
            child: Card(
              color: Colors.grey[300],
              child: Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _tarjeta,
                        onChanged: (bool value) {
                          setState(() {
                            _tarjeta = value;
                            _paypal = false;
                            _efectivo = false;
                          });
                        },
                      ),
                      Text('Tarjeta de débito/crédito')
                    ],
                  ),
                  Image(
                    image: AssetImage('images/tarjetas.png'),
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 125,
            width: ancho,
            child: Card(
              color: Colors.grey[300],
              child: Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _efectivo,
                        onChanged: (bool value) {
                          setState(() {
                            _efectivo = value;
                            _paypal = false;
                            _tarjeta = false;
                          });
                        },
                      ),
                      Text('Efectivo')
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
