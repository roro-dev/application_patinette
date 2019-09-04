import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patinette',
      theme: ThemeData(
        primaryColor: Color(0xff6bd6f1)
      ),
      home: MyHomePage(title: 'Patinette'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _paris = CameraPosition(
    target: LatLng(48.8534100, 2.3488000),
    zoom: 14,
  );
  Location location = Location();

  Map<String, double> currentLocation;

  @override
  void initState() {
    super.initState();
    location.onLocationChanged().listen((value) {
      setState(() {
        currentLocation = value as Map<String, double>;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(
            child: new Text(
              widget.title, textAlign: TextAlign.center, style: TextStyle(
                color: Colors.white
                ),
            )
          ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _paris,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          trot1, trot2, trot3, trot4
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _getLocation,
        label: Text('Déverouiller'),
        icon: Icon(Icons.lock_open),
        backgroundColor: Color(0xff6bd6f1),
      ),
    );
  }

  Future<Map<String, double>> _getLocation() async {
    var currentLocation = <String, double>{};
    try {
      currentLocation = (await location.getLocation()) as Map<String, double>;
    } catch (e) {
      currentLocation = null;
    }
    print(currentLocation);
    print("Current coordinates: ${currentLocation["latitude"]}, ${currentLocation["longitude"]}");
    return currentLocation;
  }

}

/// Points des trottinettes
Marker trot1 = Marker(
  markerId: MarkerId('trotinette-1'),
  position: LatLng(48.88503, 2.34435),
  infoWindow: InfoWindow(title: 'Libre'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
);

Marker trot2 = Marker(
  markerId: MarkerId('trotinette-2'),
  position: LatLng(48.892, 2.34749),
  infoWindow: InfoWindow(title: 'Libre'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
);

Marker trot3 = Marker(
  markerId: MarkerId('trotinette-3'),
  position: LatLng(48.8933, 2.32763),
  infoWindow: InfoWindow(title: 'Libre'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
);

Marker trot4 = Marker(
  markerId: MarkerId('trotinette-4'),
  position: LatLng(48.8929, 2.33111),
  infoWindow: InfoWindow(title: 'Libre'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
);