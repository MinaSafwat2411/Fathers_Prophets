import 'package:fathers_prophets/data/repositories/base/base_repository.dart';
import 'package:fathers_prophets/domain/usecases/base/i_base_use_case.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IBaseUseCase)
class BaseUseCase implements IBaseUseCase{
  final BaseRepository mBaseRepository;

  BaseUseCase(this.mBaseRepository);
  
}