import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tienda/src/models/categoria.dart';
import 'package:tienda/src/providers/productos_providers.dart';
import 'package:tienda/src/providers/usuarios_providers.dart';

class DrawerComponent extends StatefulWidget {
  @override
  _DrawerComponentState createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  List<Categoria> lista = [];
  ProductosProviders productosProviders = ProductosProviders();
  Map _datosCarrito;
  List<Map<String, dynamic>> categorias = [
    {'id': '10', 'nombre': 'Alimento'},
    {'id': '20', 'nombre': 'Bedidas'},
    {'id': '1010', 'nombre': 'Carnes'},
    {'id': '1020', 'nombre': 'Verduras'},
    {'id': '2010', 'nombre': 'Vinos'},
    {'id': '30', 'nombre': 'Ferreteria'},
    {'id': '3010', 'nombre': 'Tornillos'},
    {'id': '3020', 'nombre': 'Herramientas'},
    {'id': '302010', 'nombre': 'Electricidad'},
    {'id': '302020', 'nombre': 'Accesorio de Herramientas'},
    {'id': '2020', 'nombre': 'Refresco'},
  ];
  String _usuario = '';
  final LocalStorage storage = new LocalStorage('user_app');
  @override
  void initState() {
    super.initState();
    _nombreUsuario();
    _ordenarCategorias();
  }

  _cargarCarrito() {
    _datosCarrito = productosProviders.sizeCarrito();
  }

  @override
  Widget build(BuildContext context) {
    _cargarCarrito();
    return Drawer(child: contenidoMenu());
  }

  ListView contenidoMenu() {
    return ListView(padding: EdgeInsets.zero, children: _crearItemsMenu());
  }

  List<Widget> _crearItemsMenu() {
    return [
      _headerDrawer(),
      /*_itemDrawer('Iniciar Sesion', Icons.perm_identity),
      _itemDrawer('Profile', Icons.account_circle),
      _itemDrawer('Settings', Icons.settings),*/
      /* _itemCategoria('Cemento', ['Cemento Blanco', 'Cemento Extra']),
      _itemCategoria(
          'Acero', ['Alambre y alambron', 'Castillo', 'Malla Electrosoldada']),
      _itemCategoria('Otro Materiales', ['Cemento Blanco', 'Cemento Extra']),
      _itemCategoria('Acabados', ['Cemento Blanco', 'Cemento Extra']),*/
      ..._listarCategorias(lista),
    ];
  }

  DrawerHeader _headerDrawer() {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [..._textoUsuario(), _logoCarrito()],
      ),
    );
  }

  List<Widget> _textoUsuario() {
    if (_usuario == 'Iniciar Sesion') {
      return [
        FlatButton(
          child: Text(
            _usuario,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          onPressed: () => _mostrarFormulario(context),
        )
      ];
    } else {
      return [
        Text(
          _usuario,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        InkWell(
          child: Text(
            'Cerrar Sesion',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          onTap: () {
            _borrarUsuario();
            setState(() {});
          },
        )
      ];
    }
  }

  List<Widget> _listarCategorias(List datos) {
    List<Widget> todo = [];
    datos.forEach((element) {
      var familia = element.id;
      if (element.hijos.length != 0) {
        todo.add(ExpansionTile(
          title: Text(element.nombre),
          children: _listarCategorias(element.hijos),
        ));
      } else {
        todo.add(ListTile(
          title: Text(element.nombre),
          onTap: () {
            Navigator.pushNamed(context, '/productos/$familia');
            print(familia);
            setState(() {});
          },
        ));
      }
    });
    return todo;
  }

  _ordenarCategorias() {
    categorias.forEach((element) {
      var profundidadCategoria = element['id'].toString().split('0');
      if (profundidadCategoria.length > 2) {
        _agregarHijo(
            0, profundidadCategoria, lista, element, profundidadCategoria[0]);
      } else {
        lista.add(new Categoria.fromJson(element));
      }
    });
  }

  _agregarHijo(
      int sub, List division, List categoria, Map nuevaCategoria, String id) {
    id = id + '0';
    var index = categoria.indexWhere((e) => e.id == id);

    if (index != -1) {
      _agregarHijo(sub + 1, division, categoria[index].hijos, nuevaCategoria,
          id + division[sub + 1]);
    } else {
      categoria.add(new Categoria.fromJson(nuevaCategoria));
    }
  }

  Widget _logoCarrito() {
    return InkWell(
      child: Row(
        children: [
          Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _datosCarrito['cantidad'].toString() + " Artículos",
                style: TextStyle(fontSize: 10.0, color: Colors.white),
              ),
              Text(
                "\$ " + _datosCarrito['total'].toStringAsFixed(2),
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ],
          )
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, '/carrito');
      },
    );
  }

  _mostrarFormulario(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final usuariosProviders = UsuariosProviders();
    String _usuario = '';
    String _password = '';
    String _empresa = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[200],
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 20.0),
              Icon(Icons.account_box, color: Colors.blue)
            ],
          ),
          content: Stack(
            overflow: Overflow.visible,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(Icons.account_circle),
                          labelText: 'Usuario',
                          contentPadding: EdgeInsetsDirectional.only(
                              top: 5.0, bottom: 0.0, start: 5.0, end: 5.0),
                        ),
                        onChanged: (value) {
                          _usuario = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Usuario';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Contraseña',
                          contentPadding: EdgeInsetsDirectional.only(
                              top: 5.0, bottom: 0.0, start: 5.0, end: 5.0),
                        ),
                        obscureText: true,
                        onChanged: (value) {
                          _password = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(Icons.business),
                          labelText: 'No Empresa',
                          contentPadding: EdgeInsetsDirectional.only(
                              top: 5.0, bottom: 0.0, start: 5.0, end: 5.0),
                        ),
                        obscureText: true,
                        onChanged: (value) {
                          _empresa = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Empresa ';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.blue,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            final res = await usuariosProviders.login(
                                _usuario, _password, _empresa);

                            if (res['resp']) {
                              var nombre = res['msg'].toString().split(' ');
                              _guardarUsuario(nombre[1]);
                              setState(() {});
                              Navigator.pop(context);
                            } else {
                              print(res['msg']);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Informacion incorrecta'),
                                      content: Text(res['msg']),
                                      actions: [
                                        FlatButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: Text("Ok"),
                                        )
                                      ],
                                    );
                                  });
                            }

                            setState(() {});
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _nombreUsuario() async {
    _usuario = storage.getItem('usuario');
    if (_usuario == null) {
      _usuario = 'Iniciar Sesion';
    }
    setState(() {});
  }

  _guardarUsuario(String usuario) async {
    await storage.setItem('usuario', usuario);
    _nombreUsuario();
  }

  _borrarUsuario() async {
    await storage.clear();
    _nombreUsuario();
  }
}
