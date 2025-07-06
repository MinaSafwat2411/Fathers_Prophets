import 'package:fathers_prophets/presentation/cubit/attendance/states/attendance_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/attendance/attendance_model.dart';
import '../../../../data/models/users/users_model.dart';
import '../../../../data/repositories/attendance/attendance_repository.dart';
import '../../../../domain/usecases/attendance/attendance_use_case.dart';

class AttendanceCubit extends Cubit<AttendanceStates> {
  AttendanceCubit() : super(InitialState());

  var isUpdate = true;
  var attendance = AttendanceModel();
  var servant = UserModel();
  var useCase = AttendanceUseCase(AttendanceRepository());
  List<UserModel> members = <UserModel>[];
  DateTime? selectedDate;

  static AttendanceCubit get(context) => BlocProvider.of(context);

  void onRest() {
    isUpdate = false;
    attendance = AttendanceModel();
    selectedDate = null;
    emit(OnRest());
  }

  void onUpdateItem() {
    isUpdate = true;
    emit(OnUpdateAttendance());
  }

  void onSave(AttendanceModel attendance) async {
    try {
      emit(OnLoading());
      await useCase.updateAttendance(attendance);
      emit(OnSuccess());
    } catch (e) {
      emit(OnError(e.toString()));
    }
    isUpdate = false;
    emit(OnUpdateAttendance());
  }

  void onDelete(AttendanceModel attendance) async {
    try {
      emit(OnLoading());
      await useCase.deleteAttendance(attendance.id ?? "");
      emit(OnDeleteAttendanceItem());
    } catch (e) {
      emit(OnError(e.toString()));
    }
  }
}
