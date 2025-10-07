import 'package:fathers_prophets/data/models/classes/class_model.dart';
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
import '../../../../data/services/cache/i_cache_helper.dart';
import '../../../../domain/usecases/attendance/attendance_use_case.dart';
import '../../local/cubit/local_cubit.dart';

class AddAttendanceCubit extends Cubit<AddAttendanceStates> {
  AddAttendanceCubit(this.cacheHelper) : super(InitialState());
  final ICacheHelper cacheHelper;
  static AddAttendanceCubit get(context) => BlocProvider.of(context);

  var isUpdate = true;
  var attendance = AttendanceModel();
  var servant = UserModel();
  AttendanceUseCase useCase = AttendanceUseCase(AttendanceRepository());
  UsersUseCase usersUseCase = UsersUseCase(UserRepository());
  ClassModel classModel = ClassModel();
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

    if (!context.mounted) return;

    if (datePicked != null) {
      isUpdate = true;
      selectedDate = datePicked;
      getMembers();
      attendance = AttendanceModel(
        date: datePicked,
        dateView: formatDate(datePicked, context.read<LocaleCubit>().lang),
        attendance: [
          for (var member in (classModel.members??[]))
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
    var classes =  cacheHelper.getClasses();
    classModel = classes.firstWhere((element) => servant.classId==element.docId,);
    emit(OnGetMembers());
  }

  void getUserData() {
    servant = cacheHelper.getUserData();
    emit(OnGetServants());
  }

  void onAddAttendance() async {
    isUpdate = false;
    try {
      emit(OnLoading());
      var id = await useCase.addNewAttendance(attendance);
      attendance = attendance.copyWith(
          id: id
      );
      emit(OnSuccess());
    } catch (e) {
      emit(OnError(e.toString()));
    }
  }
}
