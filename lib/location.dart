
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
      home: Scaffold(
        body: HomePage(),
      )
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final CameraPosition _paris = CameraPosition(
    target: LatLng(48.8534100, 2.3488000),
    zoom: 14,
  );
  //Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  Location location = new Location();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
        initialCameraPosition: _paris,
        onMapCreated: _onMapCreated,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
      ),
      Positioned(
        bottom: 50,
        right: 10,
        child: FlatButton(
          onPressed: _animateToUser,
          child: Icon(
            Icons.pin_drop 
          ),
          color: Colors.white,
        ),
      )
      ],
      );

  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
     mapController = controller;
    });
  }

  _animateToUser() async {
    var pos = await location.getLocation();
    print(pos);
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(pos.latitude, pos.longitude),
        zoom: 17.0,
      )
    ));
  }


}

