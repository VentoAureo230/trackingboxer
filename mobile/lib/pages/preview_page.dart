import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trackingboxer/models/photo.dart';
import 'package:trackingboxer/pages/map_page.dart';

import '../database/database_helper.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key, required this.picture});

  final XFile picture;
  @override
  State<PreviewPage> createState() => _PreviewPageState();
}
class _PreviewPageState extends State<PreviewPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Page')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Image.file(File(widget.picture.path), fit: BoxFit.cover, width: 250),
            const SizedBox(height: 24),
            Text(widget.picture.name),
            _position != null ? Text('Longitude: ${_position!.longitude} Latitude: ${_position!.latitude}'): const Text('No location data'),
            _position != null ? Container(
              height: 400,
              child: MapPage(lat: _position!.latitude, long: _position!.longitude))
            : const CircularProgressIndicator(),
            ElevatedButton(onPressed: (){_saveToPhotoDataBase(widget.picture.name,
                _position!.latitude.toString(),
                _position!.longitude.toString());}, child: Text("Sauvegarder"))
          ]),
        ),
      ),
    );
  }

  Position? _position;
  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    print(position);
    setState(() {
      _position = position;
      print(_position);
    });
  }
  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}

Future<bool> _saveToPhotoDataBase(String url, String long, String lat) async {
  final database = await DatabaseHelper().database;

  final photo = Photo(
    url: url,
    longitude: long.toString(),
    latitude: lat.toString(),
    publicationDate: DateTime.now());

  try {
    await database.insert(
      'photos',
      photo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return true;
  } catch (e) {
    print('Error creating user: $e');
    return false;
  }

}
