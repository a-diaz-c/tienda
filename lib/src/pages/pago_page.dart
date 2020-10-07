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

  final paddingInput = EdgeInsetsDirectional.only(
    top: 5.0,
    bottom: 0.0,
    start: 5.0,
    end: 5.0,
  );

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

  Map<String, dynamic> datosTarjeta = {
    'nombre': 'Hector',
    'numero': '5899 55224 4448 8881',
    'cp': '33453',
    'direccion': ' Gastos en general',
    'cvv': '123',
  };

  String emailPaypal = "email@ejemplo.com";

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

  _actulizarDatos() {
    setState(() {});
  }

  _cargarCarrito() async {
    await productosProviders
        .getProductosCarrito()
        .then((value) => datos = value);

    setState(() {});
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
              ..._cuerpoWeb()
            else
              ..._cuerpoMovil(),
            _botonContinuar(),
            footer(),
          ],
        ),
      ),
    );
  }

  List<Widget> _cuerpoWeb() {
    return [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cardEntregaWeb(),
            _cardPagoWeb(),
            _tablaProductos(),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cardFactura(MediaQuery.of(context).size.width * 0.30),
          ],
        ),
      ),
    ];
  }

  List<Widget> _cuerpoMovil() {
    return [
      _cardEntrega(),
      _cardPago(),
      _cardFactura(MediaQuery.of(context).size.width),
      _tablaProductos(),
    ];
  }

  Widget _cardEntregaWeb() {
    return Container(
      height: 400,
      child: Card(
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
                  Text('Llevamos tu orden'),
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
                  Text('Recoger tu orden'),
                ],
              ),
              _recogerTienda ? _datosRecogerTienda() : _datosEnvioDomicilio(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardEntrega() {
    return Card(
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
                Text('Llevamos tu orden'),
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
                Text('Recoge tu orden'),
              ],
            ),
            _recogerTienda ? _datosRecogerTienda() : _datosEnvioDomicilio(),
          ],
        ),
      ),
    );
  }

  Widget _cardPagoWeb() {
    return Container(
      height: 400,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                'Forma de pago',
                style: TextStyle(fontSize: 20),
              ),
              if (MediaQuery.of(context).size.width > 900)
                _pagoWeb()
              else
                ..._pagoMovil(),
              _mostrarMetodoPago(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardPago() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              'Forma de pago',
              style: TextStyle(fontSize: 20),
            ),
            if (MediaQuery.of(context).size.width > 900)
              _pagoWeb()
            else
              ..._pagoMovil(),
            _mostrarMetodoPago(),
          ],
        ),
      ),
    );
  }

  Widget _pagoWeb() {
    return Row(
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
        Text('Paypal'),
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
        Text('Tarjeta de credito/debito'),
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
    );
  }

  List<Widget> _pagoMovil() {
    return [
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
          Text('Paypal'),
        ],
      ),
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
          Text('Tarjeta de credito/debito'),
        ],
      ),
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
          Text('Efectivo'),
        ],
      ),
    ];
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

  Widget _datosEnvioDomicilio() {
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
            onTap: () {
              _formularioDireccionEnvio();
            },
          )
        ],
      ),
    );
  }

  Widget _datosRecogerTienda() {
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
            'A nombre de: , ' +
                datosRecoger['nombre'] +
                ' ' +
                datosRecoger['apellidos'],
            style: TextStyle(fontSize: 15),
          ),
          Text(
            'Tel, ' + datosRecoger['telefono'],
            style: TextStyle(fontSize: 15),
          ),
          Text(
              'Direccion de la tenda: Applebees Plaza Galerias Diana Costera. Acapulco, Gro.'),
          InkWell(
            child: Text(
              'Cambiar',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {
              _formularioRecogerTienda();
            },
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
            Text('Paypal', style: TextStyle(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image(
                    image: AssetImage('images/paypal.png'),
                    height: 50,
                    width: 100,
                  ),
                  if (MediaQuery.of(context).size.width > 900)
                    Image(
                      image: AssetImage('images/paypal_tarjetas.png'),
                      height: 80,
                      width: 200,
                    ),
                ],
              ),
            ),
            Text(emailPaypal),
            InkWell(
              child: Text(
                'Cambiar',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () => _formularioPaypal(),
            )
          ],
        ),
      );
    } else if (_tarjeta) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Tarjeta', style: TextStyle(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image(
                    image: AssetImage('images/tarjetas.png'),
                    height: 80,
                    width: 200,
                  ),
                ],
              ),
            ),
            Text(datosTarjeta['nombre']),
            InkWell(
              child: Text(
                'Cambiar',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () => _formularioTarjeta(),
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Pagaré cuando reciba/recoja mi pedido',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      );
    }
  }

  Widget _cardFactura(double ancho) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: ancho,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                Opacity(
                  opacity: _factura ? 1 : 0.3,
                  child: Container(
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
                        Text(
                          'Email',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Text(factura['email']),
                        SizedBox(height: 5),
                        Text(
                          'Uso de CFDI',
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
                          onTap: () {
                            if (_factura) _formularioFactura();
                          },
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
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
                  side: BorderSide(color: Colors.black)),
              color: Colors.amber[400],
              onPressed: () {
                if (_tabController.index < _tabController.length - 1) {
                  _tabController.animateTo(_tabController.index + 1);
                }
              },
            ),
          ),
        ],
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

  _formularioDireccionEnvio() {
    final _keylogin = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "Direccion de envio",
                  style: TextStyle(
                      color: Color(0xFFd11507), fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(width: 20.0),
            ],
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _keylogin,
              child: Column(
                children: [
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: envio['nombre'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Nombre destinatario',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        envio['nombre'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Nombre';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: envio['apellidos'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Apellido destinatario',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        envio['apellidos'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Nombre';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: envio['empresa'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Empresa destino',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        envio['empresa'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Empresa';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: envio['telefono'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Telefono',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        envio['telefono'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Nombre';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: envio['calle'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Calle',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        envio['calle'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Calle';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: envio['numExt'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Numero Ext',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        envio['numExt'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Numero Ext';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: envio['numInt'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Numero Int',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        envio['numInt'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Numero Int';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: envio['referencia'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Referencia',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        envio['referencia'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Numero Ext';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: envio['colonia'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Colonia',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        envio['colonia'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Numero Ext';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: envio['codigoPostal'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Código Postal',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        envio['codigoPostal'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Numero Ext';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: envio['ciudad'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Cuidad',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        envio['ciudad'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Numero Ext';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: envio['estado'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Estado',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        envio['estado'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Numero Ext';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: envio['pais'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'País',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        envio['calle'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Numero Ext';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: RaisedButton(
                      child: Text(
                        "Guardar",
                        style: TextStyle(),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.amber,
                      onPressed: () {
                        if (_keylogin.currentState.validate()) {
                          _actulizarDatos();
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _formularioRecogerTienda() {
    final _keylogin = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "Entrega en tienda",
                  style: TextStyle(
                      color: Color(0xFFd11507), fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(width: 20.0),
            ],
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _keylogin,
              child: Column(
                children: [
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: datosRecoger['nombre'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Nombre',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        datosRecoger['nombre'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Nombre';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: datosRecoger['apellidos'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Apellidos',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        datosRecoger['apellidos'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Nombre';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: datosRecoger['telefono'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Telefono',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        datosRecoger['telefono'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Nombre';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: RaisedButton(
                      child: Text(
                        "Guardar",
                        style: TextStyle(),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.amber,
                      onPressed: () {
                        if (_keylogin.currentState.validate()) {
                          _actulizarDatos();
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _formularioPaypal() {
    final _keylogin = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "Email de Paypal",
                  style: TextStyle(
                      color: Color(0xFFd11507), fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(width: 20.0),
            ],
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _keylogin,
              child: Column(
                children: [
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: emailPaypal,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Email',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        emailPaypal = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Email no valido';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: RaisedButton(
                      child: Text(
                        "Guardar",
                        style: TextStyle(),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.amber,
                      onPressed: () {
                        if (_keylogin.currentState.validate()) {
                          _actulizarDatos();
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _formularioTarjeta() {
    final _keylogin = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "Datos de la tarjeta",
                  style: TextStyle(
                      color: Color(0xFFd11507), fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(width: 20.0),
            ],
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _keylogin,
              child: Column(
                children: [
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: datosTarjeta['nombre'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Nombre (Como está en la tarjeta)',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        datosTarjeta['nombre'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Nombre';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: datosTarjeta['numero'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Numero de tarjeta',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        datosTarjeta['numero'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Numero de tarjeta';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: datosTarjeta['cp'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'CP',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        datosTarjeta['CP'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'CP';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: datosTarjeta['direccion'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Direccion',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        datosTarjeta['direccion'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Direccion';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: datosTarjeta['cvv'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'CVV',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        datosTarjeta['cvv'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'CVV';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: RaisedButton(
                      child: Text(
                        "Guardar",
                        style: TextStyle(),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.amber,
                      onPressed: () {
                        if (_keylogin.currentState.validate()) {
                          _actulizarDatos();
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _formularioFactura() {
    final _keylogin = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "Datos de la tarjeta",
                  style: TextStyle(
                      color: Color(0xFFd11507), fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(width: 20.0),
            ],
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _keylogin,
              child: Column(
                children: [
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: factura['rfc'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Razón social o nombre',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        factura['nombre'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Nombre';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: factura['rfc'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'RFC',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        factura['rfc'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'RFC';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: factura['email'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Email de facturación',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        factura['email'] = value;
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      initialValue: factura['usoDeCEDI'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Uso de CFDI',
                        contentPadding: paddingInput,
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        factura['usoDeCEDI'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Nombre';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: RaisedButton(
                      child: Text(
                        "Guardar",
                        style: TextStyle(),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.amber,
                      onPressed: () {
                        if (_keylogin.currentState.validate()) {
                          _actulizarDatos();
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
