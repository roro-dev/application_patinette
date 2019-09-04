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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Color(0xff6bd6f1)
      ),
      home: MyHomePage(title: 'Patinette'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
  
  var location = new Location();
  Map<String, double> userLocation;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
        onPressed: () {
          _getLocation().then((value) {
            setState(() {
              userLocation = value;
            });
          });
        },
        label: Text('Déverouiller'),
        icon: Icon(Icons.lock_open),
        backgroundColor: Color(0xff6bd6f1),
      ),
    );
  }

  Future<void> _neverSatisfied() async {
  var currentLocation = _getLocation();
  print(currentLocation);
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Rewind and remember'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('You will never be satisfied.'),
              Text('You\’re like me. I’m never satisfied.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Regret'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
  Future<Map<String, double>> _getLocation() async {
    var currentLocation = <String, double>{};
    try {
      currentLocation = (await location.getLocation()) as Map<String, double>;
    } catch (e) {
      currentLocation = null;
    }
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