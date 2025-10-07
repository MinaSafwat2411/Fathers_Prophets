import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';

abstract class IGoogleDriveUploader {
  Future<String?> uploadFileToDrive(File file, String fileName);

  Future<String?> uploadImage({required bool fromCamera});

  Future<String?> uploadVideo();

  Future<String?> uploadAudio();

  Future<String?> uploadTextFile();

  Future<String?> uploadPdfFile();

  Future<String?> deleteFile(String fileId);
}

