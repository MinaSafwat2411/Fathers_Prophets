import 'package:fathers_prophets/core/widgets/custom_button.dart';
import 'package:fathers_prophets/core/widgets/custom_loading.dart';
import 'package:fathers_prophets/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../../data/models/attendance/attendance_model.dart';
import '../../cubit/attendance/cubit/attendance_cubit.dart';
import '../../cubit/attendance/states/attendance_states.dart';
import '../../cubit/local/cubit/local_cubit.dart';

class AttendanceDetailsScreen extends StatelessWidget {
  const AttendanceDetailsScreen({super.key, required this.attendance});

  final AttendanceModel attendance;

  @override
  Widget build(BuildContext context) {
    var cubit = AttendanceCubit.get(context);
    var localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    cubit.attendance = attendance;
    return WillPopScope(
      onWillPop: () {
        if (cubit.isUpdate) {
          context.pop(null);
          return Future.value(false);
        } else {
          context.pop(cubit.attendance);
          return Future.value(false);
        }
      },
      child: BlocConsumer<AttendanceCubit, AttendanceStates>(
        builder:
            (context, state) => Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    if (cubit.isUpdate) {
                      context.pop(null);
                    } else {
                      context.pop(attendance);
                    }
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                title: Text(cubit.attendance.dateView ?? ""),
                actions: [
                  IconButton(onPressed: ()async {
                    var  result = await context.pushNamed(AppRoutes.pin.name,extra: AppRoutes.attendanceDetails.name);
                    result as bool;
                    if(result==true){
                      cubit.onDelete(attendance);
                    }
                  }, icon: Icon(Icons.delete_outline))
                ],
              ),
              body: Stack(
                children: [
                  state is OnLoading
                      ? CustomLoading(isDark:  context.read<LocaleCubit>().isDark)
                      : SizedBox(),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Text(
                              localize.translate('shmas'),
                              style: textTheme.labelSmall,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Text(
                              localize.translate('tnawel'),
                              style: textTheme.labelSmall,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Text(
                              localize.translate('odas'),
                              style: textTheme.labelSmall,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Text(
                              localize.translate('sunday_school'),
                              style: textTheme.labelSmall,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Card(
                                  child: SizedBox(
                                    height: 60,
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                          ),
                                          child: Text(
                                            cubit.attendance
                                                    .attendance?[index]
                                                    ?.name ??
                                                "",
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Checkbox(
                                              value:
                                              cubit.attendance
                                                      .attendance?[index]
                                                      ?.shmas ??
                                                  false,
                                              onChanged: (value) {
                                                cubit.attendance
                                                    .attendance?[index]
                                                    ?.shmas = value;
                                                cubit.onUpdateItem();
                                              },
                                              activeColor: AppColors.green,
                                            ),
                                            Checkbox(
                                              value:
                                              cubit.attendance
                                                      .attendance?[index]
                                                      ?.tnawel ??
                                                  false,
                                              onChanged: (value) {
                                                cubit.attendance
                                                    .attendance?[index]
                                                    ?.tnawel = value;
                                                cubit.onUpdateItem();
                                              },
                                              activeColor: AppColors.green,
                                            ),
                                            Checkbox(
                                              value:
                                              cubit.attendance
                                                      .attendance?[index]
                                                      ?.odas ??
                                                  false,
                                              onChanged: (value) {
                                                cubit.attendance
                                                    .attendance?[index]
                                                    ?.odas = value;
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
                                                cubit.attendance
                                                    .attendance?[index]
                                                    ?.sundaySchool = value;
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
                          separatorBuilder:
                              (context, index) => SizedBox(height: 1),
                          itemCount: cubit.attendance.attendance?.length ?? 0,
                        ),
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  isDark: false,
                  onPressed: () {
                    cubit.onSave(cubit.attendance);
                  },
                  text: localize.translate('save'),
                  isEnabled: cubit.isUpdate,
                  btnColor: AppColors.green,
                  height: 56,
                ),
              ),
            ),
        listener: (context, state) {
          switch(state){
            case OnSuccess() : context.pop(cubit.attendance);
            case OnDeleteAttendanceItem() : context.pop(true);
          }
        },
        buildWhen: (previous, current) => current is! InitialState,
      ),
    );
  }
}
