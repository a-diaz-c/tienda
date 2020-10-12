import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tienda/src/components/drawer.dart';
import 'package:tienda/src/components/footer.dart';
import 'package:tienda/src/components/navbar.dart';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:tienda/src/providers/usuarios_providers.dart';

class IdentificarsePage extends StatefulWidget {
  @override
  _IdentificarsePageState createState() => _IdentificarsePageState();
}

class _IdentificarsePageState extends State<IdentificarsePage> {
  ScrollController _rrectController = ScrollController();
  final usuariosProviders = UsuariosProviders();
  final LocalStorage storage = new LocalStorage('user_app');

  @override
  Widget build(BuildContext context) {
    double anchoPantalla = MediaQuery.of(context).size.width;
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
            /* if ( anchoPantalla > 900)
              _cuerpoWeb()
            else */
            cuerpoMovil(),
            footer(),
          ],
        ),
      ),
    );
  }

  Widget cuerpoMovil() {
    return Container(
      child: Column(
        children: [
          _ingresarMovil(),
          _registrarMovil(),
        ],
      ),
    );
  }

  _guardarUsuario(String usuario) async {
    await storage.setItem('usuario', usuario);
  }

  Widget _ingresarMovil() {
    final _keylogin = GlobalKey<FormState>();
    String nombre = '';
    String password = '';
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _keylogin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _titulo('Ingresa a tu cuenta'),
              Container(
                width: 300,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Email',
                    contentPadding: EdgeInsetsDirectional.only(
                        top: 5.0, bottom: 0.0, start: 5.0, end: 5.0),
                  ),
                  onChanged: (value) {
                    nombre = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email invalido';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                width: 300,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Contraseña',
                    contentPadding: EdgeInsetsDirectional.only(
                        top: 5.0, bottom: 0.0, start: 5.0, end: 5.0),
                  ),
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Ingrese constraseña';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: RaisedButton(
                  child: Text(
                    "Iniciar Sesion",
                    style: TextStyle(),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.amber,
                  onPressed: () async {
                    if (_keylogin.currentState.validate()) {
                      print("datos " + nombre + " " + password);
                      final res =
                          await usuariosProviders.login(nombre, password);
                      print(res);
                      if (res['resp']) {
                        var nombre = res['msg'].toString().split(' ');
                        _guardarUsuario(nombre[1]);
                        setState(() {});
                        Navigator.pushNamed(context, 'pago');
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
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text("Ok"),
                                )
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registrarMovil() {
    final _keyRegistro = GlobalKey<FormState>();
    String nombre = '';
    String email = '';
    String password = '';
    String passwordDos = '';
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _keyRegistro,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _titulo('¡Registrate!'),
              Container(
                width: 300,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Nombre',
                    contentPadding: EdgeInsetsDirectional.only(
                      top: 0.0,
                      bottom: 0.0,
                      start: 5.0,
                      end: 5.0,
                    ),
                  ),
                  onChanged: (value) {
                    nombre = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Ingrese Nombre';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                width: 300,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Email',
                    contentPadding: EdgeInsetsDirectional.only(
                        top: 5.0, bottom: 0.0, start: 5.0, end: 5.0),
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (value) =>
                      EmailValidator.validate(value) ? null : 'Email invalido',
                ),
              ),
              Container(
                width: 300,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Contrseña',
                    contentPadding: EdgeInsetsDirectional.only(
                        top: 5.0, bottom: 0.0, start: 5.0, end: 5.0),
                  ),
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (value) =>
                      value.isEmpty ? 'Ingrese Contraseña' : null,
                ),
              ),
              Container(
                width: 300,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Confirmar Contraseña',
                    contentPadding: EdgeInsetsDirectional.only(
                        top: 5.0, bottom: 0.0, start: 5.0, end: 5.0),
                  ),
                  obscureText: true,
                  onChanged: (value) {
                    passwordDos = value;
                  },
                  validator: (value) =>
                      value.isEmpty ? 'Ingrese Contraseña' : null,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: RaisedButton(
                  child: Text(
                    "Crear Cuenta",
                    style: TextStyle(),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.amber,
                  onPressed: () {
                    if (_keyRegistro.currentState.validate()) {
                      if (password != passwordDos) {
                        _alert("Las contraseñas son diferentes");
                      } else {
                        print('$nombre $email $password $passwordDos');
                        Navigator.pushNamed(context, 'pago');
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titulo(String texto) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        texto,
        style: TextStyle(
            color: Colors.blue[900],
            fontSize: 20.0,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  _alert(String mensaje) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(mensaje),
          );
        });
  }

  _login(String usuario, String password, String empresa) async {
    final res = await usuariosProviders.login(usuario, password);
    print(res);
  }
}
