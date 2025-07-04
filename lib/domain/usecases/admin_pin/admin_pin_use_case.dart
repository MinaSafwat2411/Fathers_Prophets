import 'package:fathers_prophets/data/repositories/admin_pin/admin_pin_repository.dart';
import '../../../data/models/admin_pin/admin_pin_model.dart';

class AdminPinUseCase {
  final AdminPinRepository adminPinRepository;

  AdminPinUseCase(this.adminPinRepository);

  Future<bool> checkAdminPin(AdminPinModel pin) async {
    return await adminPinRepository.checkAdminPin(pin);
  }
}