import 'package:fathers_prophets/data/models/splash/splash_model.dart';
import 'package:fathers_prophets/data/repositories/splash/splash_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/splash/i_splash_repository.dart';
import 'i_splash_use_case.dart';

@LazySingleton(as: ISplashUseCase)
class SplashUseCase implements ISplashUseCase{
  final ISplashRepository splashRepository;

  SplashUseCase(this.splashRepository);

  @override
  Future<SplashModel> getRequireToUpdate() async {
    final splashModel = await splashRepository.getRequireToUpdate();
    return splashModel??SplashModel(requireToUpdate: true);
  }
}