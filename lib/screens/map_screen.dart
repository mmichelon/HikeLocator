import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/trail_model.dart';
import 'dart:convert';

class MapScreen extends StatefulWidget {
//  final List<TrailModel> trails;
  final List<dynamic> newTrails;
  final userLat;
  final userLon;
//  MapScreen(this.trails, this.userLat, this.userLon);
  MapScreen(this.newTrails, this.userLat, this.userLon);

  @override
  _MapScreenState createState() => _MapScreenState(newTrails, userLat, userLon);

//  _MapScreenState createState() => _MapScreenState(trails, userLat, userLon);
}

class _MapScreenState extends State<MapScreen> {
  /// VARIABLES
  GoogleMapController mapController;
  MapType _currentMapType = MapType.normal;
  double latitude = 0;
  double longitude = 0;
  final double userLat;
  final double userLon;
// final List<TrailModel> trails;
  final List<dynamic> newTrails; //declare for new tails list

// _MapScreenState(this.trails, this.userLat, this.userLon);
  _MapScreenState(this.newTrails, this.userLat, this.userLon);

  //final LatLng _center = const LatLng(45.521563, -122.677433);

  /// FUNCTIONS

  /// creates controller and attempts to center map on phone location
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
//   _onAddMarkerButtonPressed();
  }

  /// swaps type of map view between normal and satellite
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

  /// adds marker to current center of map
  _onAddMarkerButtonPressed(hike) {
    mapController.addMarker(
      MarkerOptions(
        position: LatLng(
          userLat,
          userLon,
        ),
        infoWindowText: InfoWindowText('User\'s Location', '5 Star Rating'),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    mapController.addMarker(
      MarkerOptions(
        position: LatLng(
          hike['latitude'],
          hike['longitude'],
        ),
        infoWindowText: InfoWindowText(hike['name'], '5 Star Rating'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      ),
    );
  }

  /// BODY VIEW

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: new AppBar(title: Text('Hikes Near Me'),
            backgroundColor: Colors.green[700],),
          body: Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: _onMapCreated,
                options: GoogleMapOptions(
                  myLocationEnabled: true,
                  trackCameraPosition: true,
                  cameraPosition: CameraPosition(
                    target: LatLng(userLat, userLon),
                    //target: LatLng(latitude, longitude),
                    zoom: 12.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: <Widget>[
                      FloatingActionButton( /// map view type normal or satellite
                        onPressed: _onMapTypeButtonPressed,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.green,
                        heroTag: null,
                        child: const Icon(Icons.map, size: 36.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the Drawer if there isn't enough vertical
            // space to fit everything.
              child: ListView.builder(
                itemCount: newTrails.length,
                itemBuilder: (context, int index) {
//                 Object myText = json.encode(trails[index].trails);
//                 List<dynamic> myText2 = json.decode(myText);
                  if(newTrails.length > index) {
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        padding: EdgeInsets.all(20.0),
                        margin: EdgeInsets.all(10.0),
                        child: Text(newTrails[0][index]['name']), // Will need to change for

                      ),
                      onTap: _onAddMarkerButtonPressed(newTrails[0][index]),
                    );
                  }
                },
              )
          )
      ),
    );
  }
}

