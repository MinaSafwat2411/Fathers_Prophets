import 'package:fathers_prophets/data/repositories/base/i_base_repository.dart';
import 'package:fathers_prophets/data/services/google_drive/i_google_drive_service.dart';
import 'package:injectable/injectable.dart';

import '../../remote/i_remote_data_source.dart';
import '../../sharedPreferences/i_shared_preferences.dart';

@LazySingleton(as: IBaseRepository)
class BaseRepository implements IBaseRepository{

  final IRemoteDataSource mRemoteDataSource;
  final ISharedPreferences mSharedPreferences;
  final IGoogleDriveUploader mGoogleDriveUploader;

  BaseRepository(
      this.mRemoteDataSource,
      this.mSharedPreferences,
      this.mGoogleDriveUploader,
  );
}