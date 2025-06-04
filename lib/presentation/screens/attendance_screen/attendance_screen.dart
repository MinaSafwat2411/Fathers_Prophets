import 'package:fathers_prophets/data/models/attendance/attendance_model.dart';
import 'package:fathers_prophets/data/models/users/users_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../cubit/layout/cubit/layout_cubit.dart';
import '../../routes.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key, required this.attendanceList,required this.userData});

  final List<AttendanceModel> attendanceList;
  final UserModel userData;

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context);
    var cubit = LayoutCubit.get(context);
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          !(userData.isAdmin??false) ? Expanded(
            child: ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: attendanceList.length,
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
          ) 
              : Expanded(
            child: PageView(
              children: [
                Column(
                  children: [
                    Text("ابونا ابراهيم",style: textTheme.titleMedium,),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: attendanceList.where((element) => element.classId=="2uli6QXyKY8VrpjMz99H",).length,
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
                ),
                Column(
                  children: [
                    Text("دانيال النبي",style: textTheme.titleMedium,),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: attendanceList.where((element) => element.classId=="8aB4mDsvky0FbzOQwfTU",).length,
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
                ),
                Column(
                  children: [
                    Text("امنا سارة",style: textTheme.titleMedium,),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: attendanceList.where((element) => element.classId=="9l6zfZIO1C6OavYCvuRV",).length,
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
                ),
                Column(
                  children: [
                    Text("حنه النبيه",style: textTheme.titleMedium,),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: attendanceList.where((element) => element.classId=="bCkH6KkCRnEDMk5Ea6sf",).length,
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
                ),
                Column(
                  children: [
                    Text("دبورة النبية",style: textTheme.titleMedium,),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: attendanceList.where((element) => element.classId=="el2A2Mjm45SU5jliE29g",).length,
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
                ),
                Column(
                  children: [
                    Text("امنا رفقة",style: textTheme.titleMedium,),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: attendanceList.where((element) => element.classId=="f0nBkPZu9OJbQ0Hstqij",).length,
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
                ),
                Column(
                  children: [
                    Text("ابونا اسحق",style: textTheme.titleMedium,),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: attendanceList.where((element) => element.classId=="fE4xWCz3bvBhyZeMuk7g",).length,
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
                ),
                Column(
                  children: [
                    Text("موسي النبي",style: textTheme.titleMedium,),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: attendanceList.where((element) => element.classId=="nXB5fzKgjVkIrVrXrLDo",).length,
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
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
