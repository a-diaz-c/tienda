import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:tienda/src/components/footer.dart';
import 'package:tienda/src/components/navbar.dart';

class MapasPage extends StatefulWidget {
  MapasPage({Key key}) : super(key: key);

  @override
  _MapasPageState createState() => _MapasPageState();
}

class _MapasPageState extends State<MapasPage> {
  ScrollController _rrectController = ScrollController();
  GlobalKey<GoogleMapStateBase> _key = GlobalKey<GoogleMapStateBase>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void main() {
    GoogleMap.init('AIzaSyAPoSTQRcYogMBiJCUtW_LJlNTyOT9_H2w');
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Navbar(),
          Container(
            height: MediaQuery.of(context).size.height * 0.50,
            width: MediaQuery.of(context).size.width * 0.50,
            child: GoogleMap(
              key: _key,
              markers: {
                Marker(
                  GeoCoord(18.934104, -99.197179),
                  onTap: (markerId) async {
                    await _dialog("Applebee's Cuernavaca",
                        "Villas del Lago, 62374 Cuernavaca, Mor. Cuernavaca. C.P. 62500");
                  },
                ),
                Marker(
                  GeoCoord(16.860217, -99.873522),
                  onTap: (markerId) async {
                    await _dialog("Applebee's Acapulco",
                        "Plaza Carso, Piso 3 Local R02, Col. Granada, C.P. 11529 Ciudad de México, CDMX.");
                  },
                  onInfoWindowTap: () {
                    Text('data');
                  },
                ),
                Marker(
                  GeoCoord(19.487504, -99.153238),
                  onTap: (markerId) async {
                    await _dialog("Applebee's Vía Vallejo",
                        "Calzada Vallejo, No. 1090, Colonia Santa Cruz de las Salinas, Delegación Azcapotzalco, Ciudad de México, D.F.");
                  },
                ),
                Marker(
                  GeoCoord(19.442545, -99.204091),
                  onTap: (markerId) async {
                    await _dialog("Applebee’s Plaza Carso",
                        "Plaza Carso, Piso 3 Local R02, Col. Granada, C.P. 11529 Ciudad de México, CDMX.");
                  },
                ),
                Marker(
                  GeoCoord(25.457571, -100.979277),
                  onTap: (markerId) async {
                    await _dialog("Applebee´s Galerías Saltillo",
                        "Blvd. Nazario S. Ortiz Garza #2345 L-312, Col. Tanque de Peña. Ciudad: Saltillo, Coahuila. CP: 25279 Tel. (844) 485-0596");
                  },
                ),
              },
              initialZoom: 18,
              initialPosition: GeoCoord(16.860217, -99.873522),
              mobilePreferences: const MobileMapPreferences(
                trafficEnabled: true,
                zoomControlsEnabled: false,
              ),
              webPreferences: WebMapPreferences(
                fullscreenControl: true,
                zoomControl: true,
              ),
            ),
          ),
          footer(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final bounds = GeoCoordBounds(
            northeast: GeoCoord(16.860217, -99.873522),
            southwest: GeoCoord(16.860217, -99.873522),
          );
          GoogleMap.of(_key).moveCameraBounds(bounds);
        },
        label: Text('Acapulco'),
        icon: Icon(Icons.person_pin_circle),
      ),
    );
  }

  Future _dialog(String nombre, String direccion) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          width: 300,
          height: direccion.length.toDouble() * 1.2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(nombre,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              Text(direccion)
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: Navigator.of(context).pop,
            child: Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
