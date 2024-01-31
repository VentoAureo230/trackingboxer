import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../database/database_helper.dart';

class PhotoService {
  final DatabaseHelper _databaseHelper;

  PhotoService(this._databaseHelper);

  Future<String?> takePicture() async {
  }

  Future<void> insertPhotoAndTraining(double longitude, double latitude, String imagePath) async {
  }
}