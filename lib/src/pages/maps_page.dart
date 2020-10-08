import 'dart:async';

import 'package:flutter/material.dart';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
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
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text("Applebee's Cuernavaca"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: Navigator.of(context).pop,
                              child: Text('CLOSE'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Marker(
                    GeoCoord(16.8638, -99.8816),
                    onTap: (markerId) async {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text("Applebee's Acapulco"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: Navigator.of(context).pop,
                              child: Text('CLOSE'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Marker(
                    GeoCoord(19.487504, -99.153238),
                    onTap: (markerId) async {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text("Applebee's Vía Vallejo"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: Navigator.of(context).pop,
                              child: Text('CLOSE'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Marker(
                    GeoCoord(19.442545, -99.204091),
                    onTap: (markerId) async {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text("Applebee’s Plaza Carso"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: Navigator.of(context).pop,
                              child: Text('CLOSE'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Marker(
                    GeoCoord(25.457571, -100.979277),
                    onTap: (markerId) async {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text("Applebee´s Galerías Saltillo"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: Navigator.of(context).pop,
                              child: Text('CLOSE'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                },
                initialZoom: 5.6,
                initialPosition: GeoCoord(19.4978, -99.1269),
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
              northeast: GeoCoord(16.8638, -99.8816),
              southwest: GeoCoord(15.8638, -99.8816),
            );
            GoogleMap.of(_key).moveCameraBounds(bounds);
          },
          label: Text('Acapulco'),
          icon: Icon(Icons.person_pin_circle),
        ));
  }
}
