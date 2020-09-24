import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
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
            else
              ...cuerpoMovil(),
            footer(),
          ],
        ),
      ),
    );
  }

  Widget _cuerpoWeb() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ingresarWeb(),
          _registroWeb(),
        ],
      ),
    );
  }

  List<Widget> cuerpoMovil() {
    return [
      SizedBox(height: 40),
      _ingresarMovil(),
      _registrarMovil(),
    ];
  }

  Widget _ingresarWeb() {
    final _keylogin = GlobalKey<FormState>();
    String nombre = '';
    String empresa = '';
    String password = '';

    final anchoFormulario = MediaQuery.of(context).size.width * .5;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 20.0,
            )
          ],
        ),
        width: anchoFormulario,
        height: 300,
        padding: EdgeInsets.only(left: 20, right: 0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _keylogin,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _titulo('Ingresa a tu cuenta'),
                  Container(
                    width: anchoFormulario * 0.6,
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Email',
                        contentPadding: EdgeInsetsDirectional.only(
                          top: 5.0,
                          bottom: 0.0,
                          start: 5.0,
                          end: 5.0,
                        ),
                        errorStyle: TextStyle(height: 0),
                      ),
                      onChanged: (value) {
                        nombre = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    width: anchoFormulario * 0.6,
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Contraseña',
                        contentPadding: EdgeInsetsDirectional.only(
                          top: 5.0,
                          bottom: 0.0,
                          start: 5.0,
                          end: 5.0,
                        ),
                        errorStyle: TextStyle(height: 0),
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Constrseña';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    width: anchoFormulario * 0.6,
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Empresa',
                        contentPadding: EdgeInsetsDirectional.only(
                          top: 5.0,
                          bottom: 0.0,
                          start: 5.0,
                          end: 5.0,
                        ),
                        errorStyle: TextStyle(height: 0),
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        empresa = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Ingrese Empresa';
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
                      onPressed: () {
                        if (_keylogin.currentState.validate()) {
                          //_login(nombre, password, empresa);
                          Navigator.pushNamed(context, '/pago');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _registroWeb() {
    final _keyRegistro = GlobalKey<FormState>();
    final anchoFormulario = MediaQuery.of(context).size.width * .5;
    String nombre = '';
    String email = '';
    String password = '';
    String passwordDos = '';
    return Center(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 20.0,
            )
          ],
        ),
        width: anchoFormulario,
        height: 300,
        padding: EdgeInsets.only(left: 0, right: 20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _keyRegistro,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _titulo('¡Registrate!'),
                  Container(
                    width: anchoFormulario * 0.6,
                    height: 40,
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
                        errorStyle: TextStyle(fontSize: 9, height: 0),
                      ),
                      onChanged: (value) {
                        nombre = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    width: anchoFormulario * 0.6,
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Email',
                        contentPadding: EdgeInsetsDirectional.only(
                          top: 5.0,
                          bottom: 0.0,
                          start: 5.0,
                          end: 5.0,
                        ),
                        errorStyle: TextStyle(fontSize: 9, height: 0),
                      ),
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) => EmailValidator.validate(value)
                          ? null
                          : 'Email invalido',
                    ),
                  ),
                  Container(
                    width: anchoFormulario * 0.6,
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Contrseña',
                        contentPadding: EdgeInsetsDirectional.only(
                          top: 5.0,
                          bottom: 0.0,
                          start: 5.0,
                          end: 5.0,
                        ),
                        errorStyle: TextStyle(fontSize: 9, height: 0),
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
                    width: anchoFormulario * 0.6,
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Confirmar Contraseña',
                        contentPadding: EdgeInsetsDirectional.only(
                          top: 5.0,
                          bottom: 0.0,
                          start: 5.0,
                          end: 5.0,
                        ),
                        errorStyle: TextStyle(fontSize: 9, height: 0),
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
                            _alert("Las contraseñas no son iguales");
                          } else {
                            print('$nombre $email $password $passwordDos');
                            Navigator.pushNamed(context, '/pago');
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _ingresarMovil() {
    final _keylogin = GlobalKey<FormState>();
    String nombre = '';
    String empresa = '';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titulo('Ingresa a tu cuenta'),
              Container(
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
                ),
              ),
              Container(
                height: 60,
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
                ),
              ),
              Container(
                height: 60,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Empresa',
                    contentPadding: EdgeInsetsDirectional.only(
                        top: 5.0, bottom: 0.0, start: 5.0, end: 5.0),
                  ),
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
                  onPressed: () {
                    if (_keylogin.currentState.validate()) {
                      Navigator.pushNamed(context, '/pago');
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titulo('¡Registrate!'),
              Container(
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
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (value) =>
                      value.isEmpty ? 'Ingrese Contraseña' : null,
                ),
              ),
              Container(
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
                        Navigator.pushNamed(context, '/pago');
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
    final res = await usuariosProviders.login(usuario, password, empresa);
    print(res);
  }
}
