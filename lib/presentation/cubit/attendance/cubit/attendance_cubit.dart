import 'package:fathers_prophets/presentation/cubit/attendance/states/attendance_states.dart';
import 'package:fathers_prophets/presentation/cubit/local/cubit/local_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../data/models/attendance/attendance.dart';
import '../../../../data/models/attendance/attendance_model.dart';
import '../../../../data/models/users/users_model.dart';
import '../../../../data/repositories/attendance/attendance_repository.dart';
import '../../../../data/services/cache_helper.dart';
import '../../../../domain/usecases/attendance/attendance_use_case.dart';

class AttendanceCubit extends Cubit<AttendanceStates>{
  AttendanceCubit() : super(InitialState());

  var isUpdate = false;
  var attendance = AttendanceModel();
  var servant = UserModel();
  var useCase = AttendanceUseCase(AttendanceRepository());
  List<UserModel> members = <UserModel>[];
  DateTime? selectedDate;

  static AttendanceCubit get(context) => BlocProvider.of(context);

  void onRest(){
    isUpdate = false;
    attendance = AttendanceModel();
    selectedDate = null;
    emit(OnRest());
  }
  void onUpdateItem(){
    isUpdate = true;
    emit(OnUpdateAttendance());
  }

  void onSave(AttendanceModel attendance)async{
    try{
      emit(OnLoading());
      await useCase.updateAttendance(attendance);
      emit(OnSuccess());
    }catch(e){
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
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppColors.mirage,
                  onPrimary: Colors.white,
                  onSurface: Colors.black,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.mirage,
                  ),
                ),
              ),
              child: child!);
        });
    if (datePicked != null) {
      isUpdate = true;
      selectedDate = datePicked;
      attendance = AttendanceModel(
        date: datePicked,
        dateView: formatDate(datePicked,context.read<LocaleCubit>().lang),
        attendance: [
          for (var member in members)
            Attendance(
              name: member.name,
              uid: member.uid,
              shmas: false,
              tnawel: false,
              odas: false,
              sundaySchool: false,
            )
        ],
      );
    }
    emit(OnSelectDate());
  }
  static String formatDate(DateTime dateTime,String lang) {
    String locale = lang == "en" ? "en_US" : "ar_SA";
    DateFormat dateFormat = DateFormat("EEEE d - MMM", locale);
    return dateFormat.format(dateTime);
  }

  void getMembers(){
    members = CacheHelper.getMembers().where(
      (element) => element.classId==servant.classId,
    ).toList();
    emit(OnGetMembers());
  }

  void getUserData(){
    servant = CacheHelper.getUserData();
    emit(OnGetServants());
  }

  void onAddAttendance()async{
    isUpdate = false;
    try{
      emit(OnLoading());
      await useCase.addNewAttendance(attendance);
      emit(OnSuccess());
    }catch (e){
      emit(OnError(e.toString()));
    }

  }
}