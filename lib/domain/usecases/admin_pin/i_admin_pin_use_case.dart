import 'package:fathers_prophets/data/repositories/admin_pin/admin_pin_repository.dart';
import '../../../data/models/admin_pin/admin_pin_model.dart';

abstract class IAdminPinUseCase {
  Future<bool> checkAdminPin(AdminPinModel pin);
}