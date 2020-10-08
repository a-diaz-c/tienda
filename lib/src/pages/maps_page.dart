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

  /* static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(19.4978, -99.1269),
    zoom: 5.3,
  ); */

  /*  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(16.8638, -99.8816),
      tilt: 59.440717697143555,
      zoom: 13.00); */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              key: _key,
              markers: {
                Marker(
                  GeoCoord(34.0469058, -118.3503948),
                ),
                Marker(
                  GeoCoord(16.8638, -99.8816),
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
          Positioned(
            top: 16,
            left: 16,
            child: FloatingActionButton(
              child: Icon(Icons.person_pin_circle),
              onPressed: () {
                final bounds = GeoCoordBounds(
                  northeast: GeoCoord(16.8638, -99.8816),
                  southwest: GeoCoord(15.8638, -99.8816),
                );
                GoogleMap.of(_key).moveCameraBounds(bounds);
                /* GoogleMap.of(_key).addMarkerRaw(
                  GeoCoord(
                    (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
                    (bounds.northeast.longitude + bounds.southwest.longitude) /
                        2,
                  ),
                  onTap: (markerId) async {
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text(
                          'This dialog was opened by tapping on the marker!\n'
                          'Marker ID is $markerId',
                        ),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: Navigator.of(context).pop,
                            child: Text('CLOSE'),
                          ),
                        ],
                      ),
                    );
                  },
                ); */
              },
            ),
          ),
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
      ),
    );
  }
}
