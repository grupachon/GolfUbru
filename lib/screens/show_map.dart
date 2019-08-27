import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class showMap extends StatefulWidget {
  @override
  _showMapState createState() => _showMapState();
}

class _showMapState extends State<showMap> {
// Explicit
  static const ubruLatLong = const LatLng(15.245838, 104.847608);
  CameraPosition cameraPosiotion =
      CameraPosition(target: ubruLatLong, zoom: 16.0);

//Methode
  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
          position: ubruLatLong,
          markerId: MarkerId('UBRU'),
          infoWindow: InfoWindow(
              title: 'ม.ราชภัฏอุบล', snippet: 'มหาวิทยาลัยแห่วความสุข'),
          icon: BitmapDescriptor.defaultMarkerWithHue(60.0)),
    ].toSet();
  }

  Widget myMap() {
    return GoogleMap(
      myLocationEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: cameraPosiotion,
      onMapCreated: (GoogleMapController googleMapController) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return myMap();
  }
}
