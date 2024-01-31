import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key, required this.lat, required this.long });

  final double lat;
  final double long;

  @override
  Widget build(BuildContext context) {
    if (lat.isNaN || long.isNaN || lat.isInfinite || long.isInfinite) {
    return Center(child: Text('Les coordonnées ne sont pas valides'));
  }
    return FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(lat, long),
            initialZoom: 9.2,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  'OpenStreetMap contributors',
                  onTap: () => launchUrl(
                      Uri.parse('https://openstreetmap.org/copyright')),
                ),
              ],
            ),
          ],
        );
  }
}