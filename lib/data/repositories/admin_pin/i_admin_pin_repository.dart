import '../../models/admin_pin/admin_pin_model.dart';

abstract class IAdminPinRepository {
  Future<bool> checkAdminPin(AdminPinModel pin);
}