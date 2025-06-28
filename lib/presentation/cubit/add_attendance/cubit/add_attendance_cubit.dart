import 'package:fathers_prophets/domain/usecases/users/users_use_case.dart';
import 'package:fathers_prophets/presentation/cubit/add_attendance/states/add_attendance_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/attendance/attendance.dart';
import '../../../../data/models/attendance/attendance_model.dart';
import '../../../../data/models/users/users_model.dart';
import '../../../../data/repositories/attendance/attendance_repository.dart';
import '../../../../data/repositories/users/users_repository.dart';
import '../../../../data/services/cache_helper.dart';
import '../../../../domain/usecases/attendance/attendance_use_case.dart';
import '../../local/cubit/local_cubit.dart';

class AddAttendanceCubit extends Cubit<AddAttendanceStates> {
  AddAttendanceCubit() : super(InitialState());

  static AddAttendanceCubit get(context) => BlocProvider.of(context);

  var isUpdate = true;
  var attendance = AttendanceModel();
  var servant = UserModel();
  AttendanceUseCase useCase = AttendanceUseCase(AttendanceRepository());
  UsersUseCase usersUseCase = UsersUseCase(UserRepository());
  List<UserModel> members = <UserModel>[];
  DateTime? selectedDate;

  void onRest() {
    isUpdate = false;
    selectedDate = null;
    attendance = AttendanceModel(attendance: [], classId: servant.classId);
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

  Future<void> selectDate(BuildContext context) async {
    DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (!context.mounted) return; // ✅ Ensure widget is still mounted

    if (datePicked != null) {
      isUpdate = true;
      selectedDate = datePicked;

      attendance = AttendanceModel(
        date: datePicked,
        dateView: formatDate(datePicked, context.read<LocaleCubit>().lang),
        attendance: [
          for (var member in members)
            Attendance(
              name: member.name,
              uid: member.uid,
              shmas: false,
              tnawel: false,
              odas: false,
              sundaySchool: false,
            ),
        ],
        classId: servant.classId,
      );
      emit(OnSelectDate());
    }
  }

  static String formatDate(DateTime dateTime, String lang) {
    String locale = lang == "en" ? "en_US" : "ar_SA";
    DateFormat dateFormat = DateFormat("EEEE d - MMM", locale);
    return dateFormat.format(dateTime);
  }

  void getMembers() {
    members =
        CacheHelper.getMembers()
            .where((element) => element.classId == servant.classId)
            .toList();
    emit(OnGetMembers());
  }

  void getUserData() {
    servant = CacheHelper.getUserData();
    emit(OnGetServants());
  }

  void onAddAttendance() async {
    isUpdate = false;
    try {
      emit(OnLoading());
      await useCase.addNewAttendance(
        attendance.copyWith(
          attendance:
              attendance.attendance
                  ?.where(
                    (element) =>
                        (element?.shmas ?? false) ||
                        (element?.tnawel ?? false) ||
                        (element?.odas ?? false) ||
                        (element?.sundaySchool ?? false),
                  )
                  .toList(),
        ),
      );
      emit(OnSuccess());
    } catch (e) {
      emit(OnError(e.toString()));
    }
  }
}
