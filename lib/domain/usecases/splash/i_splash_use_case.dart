import 'package:fathers_prophets/data/models/splash/splash_model.dart';
import 'package:fathers_prophets/data/repositories/splash/splash_repository.dart';

abstract class ISplashUseCase {
  Future<SplashModel> getRequireToUpdate();
}