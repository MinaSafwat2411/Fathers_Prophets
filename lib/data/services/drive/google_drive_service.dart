import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import 'i_google_drive_service.dart';

@LazySingleton(as: IGoogleDriveUploader)
class GoogleDriveUploader  implements IGoogleDriveUploader{
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [drive.DriveApi.driveFileScope],
  );

  Future<http.Client?> _getAuthClient() async {
    final account = await _googleSignIn.signIn();
    if (account == null) return null;

    final authHeaders = await account.authHeaders;
    return GoogleAuthClient(authHeaders);
  }

  @override
  Future<String?> uploadFileToDrive(File file, String fileName) async {
    final authClient = await _getAuthClient();
    if (authClient == null) return null;

    final driveApi = drive.DriveApi(authClient);
    final media = drive.Media(file.openRead(), file.lengthSync());

    final driveFile = drive.File()..name = fileName;

    final uploadedFile =
    await driveApi.files.create(driveFile, uploadMedia: media);

    await driveApi.permissions.create(
      drive.Permission(type: "anyone", role: "reader"),
      uploadedFile.id!,
    );

    return "https://drive.google.com/uc?export=view&id=${uploadedFile.id}";
  }

  @override
  Future<String?> uploadImage({required bool fromCamera}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile == null) return null;

    final file = File(pickedFile.path);
    return await uploadFileToDrive(
        file, 'image_${DateTime.now().millisecondsSinceEpoch}.jpg');
  }

  @override
  Future<String?> uploadVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile == null) return null;

    final file = File(pickedFile.path);
    return await uploadFileToDrive(
        file, 'video_${DateTime.now().millisecondsSinceEpoch}.mp4');
  }

  @override
  Future<String?> uploadAudio() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result == null || result.files.single.path == null) return null;

    final file = File(result.files.single.path!);
    return await uploadFileToDrive(
        file, 'audio_${DateTime.now().millisecondsSinceEpoch}.mp3');
  }

  @override
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

  @override
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

  @override
  Future<String?> deleteFile(String fileId) async {
    final authClient = await _getAuthClient();
    if (authClient == null) return "Need to get auth client";

    final driveApi = drive.DriveApi(authClient);
    await driveApi.files.delete(fileId);
    return "File deleted successfully";
  }
}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = IOClient();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }

  @override
  void close() {
    _client.close();
  }
}


