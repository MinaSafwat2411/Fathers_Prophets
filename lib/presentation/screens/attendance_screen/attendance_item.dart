import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../../data/models/attendance/attendance_model.dart';
import '../../cubit/layout/cubit/layout_cubit.dart';
import '../../routes.dart';

class AttendanceItem extends StatelessWidget {
  const AttendanceItem({super.key,
    required this.attendanceList,
    required this.classId,
    required this.name
  });

  final List<AttendanceModel> attendanceList;
  final String classId;
  final String name;

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    var cubit = context.read<LayoutCubit>();
    return Column(
      children: [
        Text(name,style: textTheme.titleMedium,),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: attendanceList.where((element) => element.classId== classId,).length,
            itemBuilder: (context, parentIndex) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      child: Text(attendanceList[parentIndex].dateView??"",style: textTheme.titleMedium,),
                      onTap: () async{
                        var attendance = await context.pushNamed(AppRoutes.attendanceDetails.name,extra: attendanceList[parentIndex]);
                        if(attendance == null) {
                          return ;
                        } else{
                          cubit.afterUpdateAttendance(attendance as AttendanceModel?, parentIndex);
                        }
                      },
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: attendanceList[parentIndex].attendance?.length ?? 0,
                    itemBuilder: (context, childIndex) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(attendanceList[parentIndex].attendance?[childIndex]?.name??""),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(localize.translate('shmas'),style: textTheme.labelSmall?.copyWith(fontSize: 8),),
                                        Checkbox(value: attendanceList[parentIndex].attendance?[childIndex]?.shmas?? false,onChanged: (value) {},activeColor: AppColors.green,),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(localize.translate('tnawel'),style: textTheme.labelSmall?.copyWith(fontSize: 8),),
                                        Checkbox(value: attendanceList[parentIndex].attendance?[childIndex]?.tnawel?? false,onChanged: (value) {},activeColor: AppColors.green,),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(localize.translate('odas'),style: textTheme.labelSmall?.copyWith(fontSize: 8),),
                                        Checkbox(value: attendanceList[parentIndex].attendance?[childIndex]?.odas?? false,onChanged: (value) {},activeColor: AppColors.green,),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(localize.translate('sunday_school'),style: textTheme.labelSmall?.copyWith(fontSize: 8), maxLines: 1,),
                                        Checkbox(value: attendanceList[parentIndex].attendance?[childIndex]?.sundaySchool?? false,onChanged: (value) {},activeColor: AppColors.green,),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 0,),
                  ),
                  if(parentIndex == attendanceList.length-1)SizedBox(height: 30,)
                ],
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 0,),
          ),
        ),
      ],
    );
  }
}
