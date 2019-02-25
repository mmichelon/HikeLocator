import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../screens/list_screen.dart';
import '../models/trail_model.dart';
import '../screens/home_screen.dart';

class MapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  MapScreen(this.latitude, this.longitude);
  @override
  _MapScreenState createState() => _MapScreenState(latitude, longitude);
}

class _MapScreenState extends State<MapScreen> {
 GoogleMapController mapController;
 MapType _currentMapType = MapType.normal;
 final double latitude;
 final double longitude;
 _MapScreenState(this.latitude, this.longitude);

 //final LatLng _center = const LatLng(45.521563, -122.677433);

 void _onMapCreated(GoogleMapController controller) {
   mapController = controller;
   _onAddMarkerButtonPressed();
 }

 void _onMapTypeButtonPressed() {
   if (_currentMapType == MapType.normal) {
     mapController.updateMapOptions(
       GoogleMapOptions(mapType: MapType.satellite),
     );
     _currentMapType = MapType.satellite;
   } else {
     mapController.updateMapOptions(
       GoogleMapOptions(mapType: MapType.normal),
     );
     _currentMapType = MapType.normal;
   }
 }

 void _onAddMarkerButtonPressed() {
   mapController.addMarker(
     MarkerOptions(
       position: LatLng(
         mapController.cameraPosition.target.latitude,
         mapController.cameraPosition.target.longitude,
       ),
       infoWindowText: InfoWindowText('Random Place', '5 Star Rating'),
       icon: BitmapDescriptor.defaultMarker,
     ),
   );
 }

 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     home: Scaffold(
       appBar: AppBar(
         title: Text('Maps Sample App'),
         backgroundColor: Colors.green[700],
       ),
       body: Stack(
         children: <Widget>[
           GoogleMap(
             onMapCreated: _onMapCreated,
             options: GoogleMapOptions(
               trackCameraPosition: true,
               cameraPosition: CameraPosition(
                 target: LatLng(latitude, longitude),
                 zoom: 12.0,
               ),
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(16.0),
             child: Align(
               alignment: Alignment.topRight,
               child: Column(
                 children: <Widget>[
                   FloatingActionButton(
                     onPressed: _onMapTypeButtonPressed,
                     materialTapTargetSize: MaterialTapTargetSize.padded,
                     backgroundColor: Colors.green,
		     heroTag: null,
                     child: const Icon(Icons.map, size: 36.0),

                   ),
                   const SizedBox(height: 16.0),
                   FloatingActionButton(
                     onPressed: _onAddMarkerButtonPressed,
                     materialTapTargetSize: MaterialTapTargetSize.padded,
                     backgroundColor: Colors.green,
		     heroTag: null,
                     child: const Icon(Icons.add_location, size: 36.0),
                   ),
                 ],
               ),
             ),
           ),
         ],
       ),
     ),
   );
 }
}
