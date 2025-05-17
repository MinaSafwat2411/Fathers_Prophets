import 'package:fathers_prophets/presentation/cubit/attendance/cubit/attendance_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/attendance/states/attendance_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_loading.dart';
import '../../cubit/local/cubit/local_cubit.dart';

class AddAttendanceScreen extends StatelessWidget {
  const AddAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AttendanceCubit.get(context);
    var localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () {
        cubit.onRest();
        return Future.value(true);
      },
      child: BlocConsumer<AttendanceCubit, AttendanceStates>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                if(cubit.isUpdate||cubit.selectedDate==null){
                  cubit.onRest();
                  context.pop(null);
                }else {
                  context.pop(cubit.attendance);
                }
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text(localize.translate("add_attendance")),
          ),
          body:Stack(
            children: [
              state is OnLoading? CustomLoading(isDark: context.read<LocaleCubit>().isDark): SizedBox(),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        cubit.selectDate(context);
                      },
                      child: Text(cubit.selectedDate==null? localize.translate("select_date"): cubit.attendance.dateView??"", style: textTheme.titleLarge),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(localize.translate('shmas'),style: textTheme.labelSmall,),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(localize.translate('tnawel'),style: textTheme.labelSmall,),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(localize.translate('odas'),style: textTheme.labelSmall,),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(localize.translate('sunday_school'),style: textTheme.labelSmall,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder:
                          (context, index){ return Column(
                        children: [
                          Card(
                            child: SizedBox(
                              height: 60,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      cubit.attendance.attendance?[index]?.name ?? "",
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        value:
                                        cubit.attendance.attendance?[index]?.shmas ??
                                            false,
                                        onChanged: (value) {
                                          cubit.attendance.attendance?[index]?.shmas = value;
                                          cubit.onUpdateItem();
                                        },
                                        activeColor: AppColors.green,
                                      ),
                                      Checkbox(
                                        value:
                                        cubit.attendance.attendance?[index]?.tnawel ??
                                            false,
                                        onChanged: (value) {
                                          cubit.attendance.attendance?[index]?.tnawel = value;
                                          cubit.onUpdateItem();
                                        },
                                        activeColor: AppColors.green,
                                      ),
                                      Checkbox(
                                        value:
                                        cubit.attendance.attendance?[index]?.odas ??
                                            false,
                                        onChanged: (value) {
                                          cubit.attendance.attendance?[index]?.odas = value;
                                          cubit.onUpdateItem();
                                        },
                                        activeColor: AppColors.green,
                                      ),
                                      Checkbox(
                                        value:
                                        cubit.attendance
                                            .attendance?[index]
                                            ?.sundaySchool ??
                                            false,
                                        onChanged: (value) {
                                          cubit.attendance.attendance?[index]?.sundaySchool =
                                              value;
                                          cubit.onUpdateItem();
                                        },
                                        activeColor: AppColors.green,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 1),
                      itemCount: cubit.attendance.attendance?.length ?? 0,
                    ),
                  ),
                  SizedBox(height: 100,)
                ],
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              onPressed: () {
                cubit.onAddAttendance();
              },
              text: localize.translate('save'),
              isEnabled: cubit.selectedDate!=null,
              btnColor: AppColors.green,
              height: 56,
              isDark: false,
            ),
          ),
        ),
        listener: (context, state) {},
        buildWhen:(previous, current) => current is! InitialState,
      ),
    );
  }
}
