import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tienda/src/models/categoria.dart';
import 'package:tienda/src/providers/productos_providers.dart';
import 'package:tienda/src/providers/usuarios_providers.dart';

class Navbar extends StatefulWidget {
  Navbar({Key key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  ProductosProviders productosProviders = ProductosProviders();
  List<Categoria> lista = [];
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

  @override
  Widget build(BuildContext context) {
    _cargarCarrito();
    return LayoutBuilder(builder: (context, constraints) {
      double anchoPantalla = MediaQuery.of(context).size.width;
      if (anchoPantalla > 900) {
        return Container(
          //padding: EdgeInsets.symmetric(horizontal: 10.0),
          color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textoNavBar(),
              _fieldBuscar(anchoPantalla, context),
              _menu(),
            ],
          ),
        );
      } /*else if (anchoPantalla > 500 && anchoPantalla <= 900) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textoNavBar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _logoTienda(),
                  _carrito(context),
                ],
              ),
              Row(
                children: [
                  _textField(anchoPantalla),
                ],
              ),
            ],
          ),
        );
      } */
      else {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textoNavBar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                  _logoTienda(),
                ],
              ),
              Row(
                children: [
                  _textField(anchoPantalla),
                ],
              ),
            ],
          ),
        );
      }
    });
  }

  Widget _textoNavBar() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
      child: SelectableText(
        "¿Tienes alguna duda? Llámanos  (744) 484.9493",
        style: TextStyle(fontSize: 10.0, color: Colors.white),
      ),
    );
  }

  Widget _fieldBuscar(double anchoPantalla, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _logoTienda(),
          SizedBox(
            height: 20.0,
          ),
          _textField(anchoPantalla),
          _carrito(context),
        ],
      ),
    );
  }

  Widget _logoTienda() {
    return Container(
      child: InkWell(
        child: Image(
          image: AssetImage('images/LogotipoPaginaWeb.png'),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/');
        },
      ),
    );
  }

  Widget _textField(double anchoPantalla) {
    double ancho = (anchoPantalla > 900) ? 400 : anchoPantalla * 0.90;
    return Flexible(
      child: Container(
        width: ancho,
        height: 30.0,
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            labelText: 'Buscar Producto',
            floatingLabelBehavior: FloatingLabelBehavior.never,
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsetsDirectional.only(
                top: 5.0, bottom: 5.0, start: 10.0, end: 10.0),
          ),
        ),
      ),
    );
  }

  Widget _carrito(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10.0),
      child: Row(
        children: [
          _iconoUsuario(),
          _usuario == 'Iniciar Sesion'
              ? FlatButton(
                  child: _textoUsuario(),
                  onPressed: () => _mostrarFormulario(context),
                )
              : _menuUsuario(),
          SizedBox(width: 10.0),
          _logoCarrito()
        ],
      ),
    );
  }

  Widget _iconoUsuario() {
    return IconButton(
      icon: Icon(Icons.account_circle),
      onPressed: () {
        _mostrarFormulario(context);
      },
    );
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

  Widget _menuUsuario() {
    return PopupMenuButton(
      onSelected: (value) {
        value == 'cerrar' ? _borrarUsuario() : print("Perfil del usuario");
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'Perfil',
          child: Text('Perfil'),
        ),
        PopupMenuItem(
          value: 'cerrar',
          child: Text('Cerrar Sesion'),
        ),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: _textoUsuario(),
      ),
      offset: Offset(0, 100),
      tooltip: 'Mostrar Menu',
    );
  }

  Widget _textoUsuario() {
    return Container(
      padding: EdgeInsets.all(2.0),
      child: Text(
        _usuario,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
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

  _cargarCarrito() {
    _datosCarrito = productosProviders.sizeCarrito();
  }

  Widget _menu() {
    return Container(
      color: Colors.blue[800],
      child: Row(
        children: _addCategoriasMenu(),
      ),
    );
  }

  List<Widget> _addCategoriasMenu() {
    List<Widget> salida = [];
    lista.forEach((element) {
      //salida.add(_itemMenu(element.nombre, element.hijos));
      salida.add(ListarMenu(
        title: element.nombre,
        hijos: element.hijos,
        rootMenu: true,
      ));
    });
    return salida;
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

class ListarMenu extends StatefulWidget {
  final String title;
  final bool rootMenu;
  final List<Categoria> hijos;
  const ListarMenu({Key key, this.title, this.rootMenu = false, this.hijos})
      : super(key: key);

  @override
  _ListarMenuState createState() => _ListarMenuState();
}

class _ListarMenuState extends State<ListarMenu> {
  Color fondoMenu = Colors.blue[800];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: GestureDetector(
          onTap: () {
            Offset offset = widget.rootMenu ? Offset(0, -30) : Offset(-150, 0);

            final RenderBox button = context.findRenderObject();
            final RenderBox overlay =
                Overlay.of(context).context.findRenderObject();
            final RelativeRect position = RelativeRect.fromRect(
              Rect.fromPoints(
                button.localToGlobal(Offset.zero, ancestor: overlay),
                button.localToGlobal(button.size.bottomRight(Offset.zero),
                    ancestor: overlay),
              ),
              offset & overlay.size,
            );
            showMenu(
                    color: fondoMenu,
                    context: context,
                    position: position,
                    items: _generarItem())
                .then((selectedValue) {
              // do something with the value
              if (Navigator.canPop(context)) Navigator.pop(context);
            });
          },
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            color: fondoMenu,
            textStyle: Theme.of(context).textTheme.subtitle1,
            elevation: widget.rootMenu ? 2.0 : 0.0,
            child: Padding(
              padding:
                  widget.rootMenu ? EdgeInsets.all(8.0) : EdgeInsets.all(0.0),
              child: Container(
                color: fondoMenu,
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        widget.title,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    if (!widget.rootMenu) Spacer(),
                    if (!widget.rootMenu)
                      Icon(Icons.arrow_right, color: Colors.white)
                    else
                      Icon(Icons.arrow_drop_down, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List _generarItem() {
    List<PopupMenuEntry> items = [];

    widget.hijos.forEach((element) {
      var familia = element.id;
      if (element.hijos.length == 0) {
        items.add(PopupMenuItem(
          value: element.id,
          child: InkWell(
            child: Text(
              element.nombre,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/productos/$familia');
              print(familia);
              setState(() {});
            },
          ),
        ));
      } else {
        items.add(PopupMenuItem(
          value: element.id,
          child: ListarMenu(
            title: element.nombre,
            hijos: element.hijos,
          ),
        ));
      }
    });

    return items;
  }
}
