import 'package:flutter/material.dart';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:tienda/src/components/drawer.dart';
import 'package:tienda/src/components/footer.dart';
import 'package:tienda/src/components/navbar.dart';

class DireccionesPage extends StatefulWidget {
  final String tipo;

  const DireccionesPage({Key key, this.tipo}) : super(key: key);
  @override
  _DireccionesPageState createState() => _DireccionesPageState();
}

class _DireccionesPageState extends State<DireccionesPage> {
  final paddingInput = EdgeInsetsDirectional.only(
    top: 5.0,
    bottom: 0.0,
    start: 5.0,
    end: 5.0,
  );
  ScrollController _rrectController = ScrollController();

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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Navbar(),
                widget.tipo == "1" ? _envio() : _facturacion(),
                footer(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _envio() {
    final _keylogin = GlobalKey<FormState>();
    String nombre = 'Hector';
    String apellido = 'Nunez';
    String empresa = 'Kingo System';
    String sexo = 'H';
    String telefono = '7444849493';
    String calle = 'Av. Costera Miguel Aleman';
    String numExt = '1252';
    String numInt = '18';
    String referencia = 'En la torre de Acapulco';
    String colonia = 'Club Deportivo';
    String codigoPostal = '39690';
    String ciudad = 'Acapulco';
    String estado = 'Guerrero';
    String pais = 'México';

    return Column(
      children: [
        Text('Editar Direccion de envío'),
        Form(
          key: _keylogin,
          child: Column(
            children: [
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: TextFormField(
                  initialValue: nombre,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Nombre destinatario',
                    contentPadding: paddingInput,
                    errorStyle: TextStyle(height: 0),
                  ),
                  onChanged: (value) {
                    nombre = value;
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
                  initialValue: apellido,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Apellido destinatario',
                    contentPadding: paddingInput,
                    errorStyle: TextStyle(height: 0),
                  ),
                  onChanged: (value) {
                    apellido = value;
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
                  initialValue: empresa,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Empresa destino',
                    contentPadding: paddingInput,
                    errorStyle: TextStyle(height: 0),
                  ),
                  onChanged: (value) {
                    empresa = value;
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
                child: Row(
                  children: [
                    Text('Sexo '),
                    DropdownButton(
                      value: sexo,
                      onChanged: (String newValue) {
                        setState(() {
                          sexo = newValue;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'H',
                          child: Text('H'),
                        ),
                        DropdownMenuItem(
                          value: 'M',
                          child: Text('M'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: TextFormField(
                  initialValue: telefono,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Telefono',
                    contentPadding: paddingInput,
                    errorStyle: TextStyle(height: 0),
                  ),
                  onChanged: (value) {
                    telefono = value;
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
                  initialValue: calle,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Calle',
                    contentPadding: paddingInput,
                    errorStyle: TextStyle(height: 0),
                  ),
                  onChanged: (value) {
                    calle = value;
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
                  initialValue: numExt,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Numero Ext',
                    contentPadding: paddingInput,
                    errorStyle: TextStyle(height: 0),
                  ),
                  onChanged: (value) {
                    numExt = value;
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
                  initialValue: numInt,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Numero Int',
                    contentPadding: paddingInput,
                    errorStyle: TextStyle(height: 0),
                  ),
                  onChanged: (value) {
                    numInt = value;
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
                  initialValue: referencia,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Referencia',
                    contentPadding: paddingInput,
                    errorStyle: TextStyle(height: 0),
                  ),
                  onChanged: (value) {
                    referencia = value;
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
                  initialValue: colonia,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Colonia',
                    contentPadding: paddingInput,
                    errorStyle: TextStyle(height: 0),
                  ),
                  onChanged: (value) {
                    colonia = value;
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
                  initialValue: codigoPostal,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Código Postal',
                    contentPadding: paddingInput,
                    errorStyle: TextStyle(height: 0),
                  ),
                  onChanged: (value) {
                    codigoPostal = value;
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
                  initialValue: ciudad,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Cuidad',
                    contentPadding: paddingInput,
                    errorStyle: TextStyle(height: 0),
                  ),
                  onChanged: (value) {
                    ciudad = value;
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
                  initialValue: estado,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Estado',
                    contentPadding: paddingInput,
                    errorStyle: TextStyle(height: 0),
                  ),
                  onChanged: (value) {
                    estado = value;
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
                  initialValue: pais,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'País',
                    contentPadding: paddingInput,
                    errorStyle: TextStyle(height: 0),
                  ),
                  onChanged: (value) {
                    calle = value;
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
                      Navigator.pushNamed(context, '/pago');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _facturacion() {
    final _keylogin = GlobalKey<FormState>();
    String nombre = 'Kingo Systems SA de CV';
    String rfc = 'KYS010331243';
    String email = '';
    String usoDeCEDI = 'G03 - Gastos en general';
    return Column(
      children: [
        Text('Datos de Facturacion'),
        Form(
          key: _keylogin,
          child: Column(
            children: [
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: TextFormField(
                  initialValue: rfc,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Razón social o nombre',
                    contentPadding: paddingInput,
                    errorStyle: TextStyle(height: 0),
                  ),
                  onChanged: (value) {
                    nombre = value;
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
                  initialValue: rfc,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'RFC',
                    contentPadding: paddingInput,
                    errorStyle: TextStyle(height: 0),
                  ),
                  onChanged: (value) {
                    rfc = value;
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
                  initialValue: email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Email de facturación',
                    contentPadding: paddingInput,
                    errorStyle: TextStyle(height: 0),
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                ),
              ),
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: TextFormField(
                  initialValue: usoDeCEDI,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Uso de CFDI',
                    contentPadding: paddingInput,
                    errorStyle: TextStyle(height: 0),
                  ),
                  onChanged: (value) {
                    usoDeCEDI = value;
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
                      Navigator.pushNamed(context, '/pago');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
