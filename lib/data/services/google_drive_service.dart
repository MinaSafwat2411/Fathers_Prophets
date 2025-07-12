import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';


class GoogleDriveUploader {
  final String serviceAccountJsonPath =
      'assets/json/fathers-prophets-458809-577830d3f74d.json';
  final String folderId = '18b8OqS14QkOxQ6KqX2cKxzJD0t8ByUYM';



  Future<void> init() async {
    await _getAuthClient();
  }
  Future<AuthClient?> _getAuthClient() async {
    final jsonString = await rootBundle.loadString(serviceAccountJsonPath);
    final credentials =
    ServiceAccountCredentials.fromJson(json.decode(jsonString));
    return await clientViaServiceAccount(
        credentials, [drive.DriveApi.driveFileScope]);
  }

  Future<String?> uploadFileToDrive(File file, String fileName) async {
    final authClient = await _getAuthClient();
    if (authClient == null) return null;

    final driveApi = drive.DriveApi(authClient);
    final media = drive.Media(file.openRead(), file.lengthSync());

    final driveFile = drive.File()
      ..name = fileName
      ..parents = [folderId];

    final uploadedFile =
    await driveApi.files.create(driveFile, uploadMedia: media);

    await driveApi.permissions.create(
      drive.Permission(type: "anyone", role: "reader"),
      uploadedFile.id!,
    );

    // Return the direct view link
    return "https://drive.google.com/uc?export=view&id=${uploadedFile.id}";
  }

  Future<String?> uploadImage({required bool fromCamera}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile == null) return null;

    final file = File(pickedFile.path);
    return await uploadFileToDrive(
        file, 'image_${DateTime.now().millisecondsSinceEpoch}.jpg');
  }

  Future<String?> uploadVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile == null) return null;

    final file = File(pickedFile.path);
    return await uploadFileToDrive(
        file, 'video_${DateTime.now().millisecondsSinceEpoch}.mp4');
  }

  Future<String?> uploadAudio() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result == null || result.files.single.path == null) return null;

    final file = File(result.files.single.path!);
    return await uploadFileToDrive(
        file, 'audio_${DateTime.now().millisecondsSinceEpoch}.mp3');
  }

  Future<String?> uploadTextFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt', 'md', 'json'],
    );
    if (result == null || result.files.single.path == null) return null;

    final file = File(result.files.single.path!);
    return await uploadFileToDrive(
        file, 'text_${DateTime.now().millisecondsSinceEpoch}.txt');
  }

  Future<String?> uploadPdfFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null || result.files.single.path == null) return null;

    final file = File(result.files.single.path!);
    return await uploadFileToDrive(
        file, 'pdf_${DateTime.now().millisecondsSinceEpoch}.pdf');
  }

  Future<String?> deleteFile(String fileUrl) async {
    final authClient = await _getAuthClient();
    if (authClient == null) return "Need to get auth client";

    // Extract file ID from URL
    final uri = Uri.parse(fileUrl);
    final fileId = uri.queryParameters['id'];

    if (fileId == null) {
      return "Invalid file URL";
    }

    final driveApi = drive.DriveApi(authClient);
    await driveApi.files.delete(fileId);
    return "File deleted successfully";
  }
}
