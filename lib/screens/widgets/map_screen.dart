import 'dart:async';

import 'package:Absher/screens/imports.dart';
class MapSelectionScreen extends StatefulWidget {
  @override
  _MapSelectionScreenState createState() => _MapSelectionScreenState();
}

class _MapSelectionScreenState extends State<MapSelectionScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>(); // Use a Set to manage markers
String? locationLink;

  @override
  void initState() {
    super.initState();
    _setDefaultLocation();
  }

  // Set the default location to the user's current position
  Future<void> _setDefaultLocation() async {
    final userLocation = await _getUserCurrentLocation();
    final CameraPosition cameraPosition = CameraPosition(
      target: LatLng(userLocation.latitude, userLocation.longitude),
      zoom: 14,
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    // Add marker for the user's current location
    _addMarker(LatLng(userLocation.latitude, userLocation.longitude));

    setState(() {});
  }

  // Helper function to get the user's current location
  Future<Position> _getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

// Function to handle sharing the location link
// Modify the _shareLocationLink function to pass location link as a result
void _shareLocationLink(BuildContext context) {
  // Check if there is a marker on the map
  if (_markers.isNotEmpty) {
    // Get the position of the first (and only) marker
    LatLng markerPosition = _markers.first.position;

    // Create a location link based on the marker's position
    String locationLink =
        "https://www.google.com/maps/search/?api=1&query=${markerPosition.latitude},${markerPosition.longitude}";

    // Navigate back to the previous screen and pass the location link as a result
    Navigator.pop(context, locationLink);
  } else {
    // Handle the case when there is no marker on the map
    print("No marker on the map");
  }
}



  // Function to handle tapping on the map to add a marker
  void _addMarker(LatLng tappedPosition) {
    // Remove any existing markers
    _markers.clear();

    // Create a new marker at the tapped position
    Marker newMarker = Marker(
      markerId: MarkerId("1"), // Use a fixed marker ID
      position: tappedPosition,
      infoWindow: InfoWindow(
        title: 'Selected Location',
      ),
      draggable: true, // Make the marker draggable
    );

    // Add the new marker to the set
    _markers.add(newMarker);

    // Update the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F9D58),
        title: Text("حدد موقعك عبر الموبايل"),
      ),
      body: Stack(
        children: [
          Container(
            child: SafeArea(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(20.42796133580664, 75.885749655962), // Default location
                  zoom: 14.4746,
                ),
                markers: _markers, // Use the Set of markers
                mapType: MapType.normal,
                myLocationEnabled: true,
                compassEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onTap: _addMarker, // Call _addMarker function on map tap
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () => _shareLocationLink(context),
              child: Icon(Icons.share),
            ),
          ),
        ],
      ),
    );
  }
}

