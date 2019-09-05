import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

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
  String result  = "";
  GoogleMapController mapController;
  static final CameraPosition _paris = CameraPosition(
    target: LatLng(48.8534100, 2.3488000),
    zoom: 13,
  );
  Location location = Location();

  @override
  void initState() {
    super.initState();
    result = "";
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
          leading: IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {},
              color: Colors.white,
            ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: _paris,
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: {
              trot1, trot2, trot3, trot4
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: result,
        onPressed: _scanQr,
        label: Text('Déverouiller'),
        icon: Icon(Icons.lock_open),
        backgroundColor: Color(0xff6bd6f1),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
     mapController = controller;
    });
  }

  Future _scanQr() async{
    String title = "Erreur";
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
        result = "Trottinette scannée avec succès : N°$result";
        title = "Succès";
      });
    } on PlatformException catch(ex) {
      if(ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Permission refusé : vous n'avez pas accepté l'accès à l'appareil photo.";
        });
      } else {
        setState(() {
         result = "Erreur inconnue";
        });
      }
    } catch(ex) {
      setState(() {
        result = "Erreur inconnue";
      });
    }
    return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(result, textAlign: TextAlign.center,),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Fermer'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ); 
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