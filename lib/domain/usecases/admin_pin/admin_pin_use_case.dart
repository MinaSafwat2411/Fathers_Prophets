import 'package:fathers_prophets/domain/usecases/admin_pin/i_admin_pin_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/admin_pin/admin_pin_model.dart';
import '../../../data/repositories/admin_pin/i_admin_pin_repository.dart';

@LazySingleton(as: IAdminPinUseCase)
class AdminPinUseCase implements IAdminPinUseCase{
  final IAdminPinRepository adminPinRepository;

  AdminPinUseCase(this.adminPinRepository);

  @override
  Future<bool> checkAdminPin(AdminPinModel pin) async {
    return await adminPinRepository.checkAdminPin(pin);
  }
}