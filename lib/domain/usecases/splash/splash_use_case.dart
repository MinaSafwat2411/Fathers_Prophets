import 'package:fathers_prophets/data/models/splash/splash_model.dart';
import 'package:fathers_prophets/data/repositories/splash/splash_repository.dart';

class SplashUseCase {
  final SplashRepository splashRepository;

  SplashUseCase(this.splashRepository);

  Future<SplashModel> getRequireToUpdate() async {
    final splashModel = await splashRepository.getRequireToUpdate();
    return splashModel??SplashModel(requireToUpdate: true);
  }
}