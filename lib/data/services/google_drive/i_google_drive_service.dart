import 'dart:io';

abstract class IGoogleDriveUploader {
  Future<String?> uploadFileToDrive(File file, String fileName);
  Future<String?> uploadImage({required bool fromCamera});
  Future<String?> uploadVideo();
  Future<String?> uploadAudio();
  Future<String?> uploadTextFile();
  Future<String?> uploadPdfFile();
  Future<String?> deleteFile(String fileId);
}