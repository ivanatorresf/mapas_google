import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Completer<GoogleMapController> _controller = Completer();

  MapType mapType = MapType.normal;
  @override
  Widget build(BuildContext context) {
    final CameraPosition puntoInicial = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(20.5075083, -86.9544752),
        tilt: 89.440717697143555,
        zoom: 9);
    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
      markerId: MarkerId('geo-location'),
      position: LatLng(20.5075083, -86.9544752),
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cozumel'),
          actions: [
            IconButton(
              icon: Icon(Icons.location_disabled),
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: LatLng(20.5075083, -86.9544752),
                        tilt: 89.440717697143555,
                        zoom: 17)));
              },
            )
          ],
        ),
        body: GoogleMap(
          mapType: mapType,
          markers: markers,
          initialCameraPosition: puntoInicial,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.layers),
          onPressed: () {
            if (mapType == MapType.normal) {
              mapType = MapType.satellite;
            } else {
              mapType = MapType.normal;
            }
            setState(() {});
          },
        ),
      ),
    );
  }
}
