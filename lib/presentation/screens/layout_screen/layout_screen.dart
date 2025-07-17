import 'package:cached_network_image/cached_network_image.dart';
import 'package:fathers_prophets/core/utils/app_colors.dart';
import 'package:fathers_prophets/presentation/cubit/add_attendance/cubit/add_attendance_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../../core/widgets/custom_drawer.dart';
import '../../../core/widgets/profile_loading_image.dart';
import '../../../data/models/attendance/attendance_model.dart';
import '../../../data/models/quizzes/quizzes_model.dart';
import '../../cubit/layout/cubit/layout_cubit.dart';
import '../../cubit/layout/states/layout_states.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import '../../routes.dart';
import '../attendance_screen/attendance_screen.dart';
import '../chat_screen/chat_screen.dart';
import '../home_screen/home_screen.dart';
import '../quizzes_screen/quiz_search.dart';
import '../quizzes_screen/quizzes_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = LayoutCubit.get(context);
    final localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () {
        if (cubit.state is OnSearchEventOpenState || cubit.state is OnSearchQuizOpenState){
          cubit.onSearchEventCloseClicked();
          return Future.value(false);
        }else{
          return Future.value(true);
        }
      },
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        buildWhen: (previous, current) => current is! InitialState,
        listener: (context, state) {},
        builder:
            (context, state) =>
            Scaffold(
              key: cubit.scaffoldKey,
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    cubit.scaffoldKey.currentState!.openDrawer();
                  },
                  icon: ClipOval(
                    child: cubit.userData.profile == '' ?Image.asset(
                      context.read<LocaleCubit>().isDark
                          ? "assets/images/logo_dark.png"
                          : "assets/images/logo_light.png",
                    ):ClipOval(
                      child: CachedNetworkImage(
                        width: 40,
                        height: 40,
                        fit: BoxFit.fill,
                        imageUrl: cubit.userData.profile??"",
                        placeholder: (context, imageProvider) => ProfileLoadingImage(
                          isDark: context.read<LocaleCubit>().isDark,
                        ),
                        errorWidget: (context, url, error) =>  ProfileLoadingImage(
                          isDark: context.read<LocaleCubit>().isDark,
                        ),
                      )
                    ),
                  ),
                ),
                title: Text(
                  localize.translate(cubit.titles[cubit.currentIndex]),
                  style: textTheme.titleLarge,
                ),
                actionsPadding: const EdgeInsets.all(16),
                actions:
                cubit.currentIndex == 0
                    ? [
                  GestureDetector(
                    child: const Icon(Icons.notifications),
                    onTap: () {
                      // context.pushNamed(AppRoutes.notifications.name);
                    },
                  ),
                ]
                    : cubit.currentIndex == 2
                    ? null
                    : [
                      if(state is OnSearchEventOpenState || state is OnSearchQuizOpenState || state is OnSearchQuizState || state is OnSearchEventState)GestureDetector(
                        child: const Icon(Icons.close),
                        onTap: () {
                          switch (cubit.currentIndex) {
                            case 0: break;
                            case 1:
                              {
                                cubit.onSearchQuizCloseClicked();
                              }
                          }
                        },
                      ),
                  if(state is! OnSearchEventOpenState && state is! OnSearchQuizOpenState && state is! OnSearchQuizState && state is! OnSearchEventState) GestureDetector(
                    child: const Icon(Icons.search),
                    onTap: () {
                      switch (cubit.currentIndex) {
                        case 0: break;
                        case 1:
                          {
                            cubit.onSearchQuizClicked();
                          }
                      }
                    },
                  ),
                  if(cubit.currentIndex == 1 && (cubit.userData.isAdmin??false)) Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: GestureDetector(
                      child: const Icon(Icons.table_chart_outlined),
                      onTap: () {
                        context.pushNamed(AppRoutes.quizzesScoreTable.name);
                      },
                    ),
                  )
                ],
                centerTitle: false,
                titleSpacing: 0,
              ),
              floatingActionButton:
              (cubit.currentIndex != 0) && (cubit.userData.isAdmin??false)
                  ? FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onPressed: () async {
                  switch (cubit.currentIndex) {
                    case 1: {
                      var quiz = await context.pushNamed(AppRoutes.addQuiz.name);
                      if (!context.mounted) return;

                      if (quiz != null) {
                        cubit.quizzes.add(quiz as QuizzesModel);
                        cubit.sortQuizzes();
                      }
                      break;
                    }


                    case 2: {
                      var attendance = await context.pushNamed(AppRoutes.addAttendance.name);
                      if (!context.mounted) return;
                      if (attendance != null) {
                        cubit.attendance.add(attendance as AttendanceModel);
                        cubit.sortAttendance(context.read<LocaleCubit>().lang);
                        context.read<AddAttendanceCubit>().onRest();
                      }
                      break;
                    }
                  }
                },
                    child: const Icon(Icons.edit),
                  )
                  : (cubit.currentIndex == 2) && (cubit.userData.isTeacher??false)?FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: () async {
                  var attendance = await context.pushNamed(AppRoutes.addAttendance.name);

                  if (!context.mounted) return;

                  if (attendance != null) {
                    cubit.attendance.add(attendance as AttendanceModel);
                    cubit.sortAttendance(context.read<LocaleCubit>().lang);
                    context.read<AddAttendanceCubit>().onRest();
                  }
                },

                child: const Icon(Icons.edit),
              ):null,
              resizeToAvoidBottomInset: false,
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, bottom: 8.0, right: 8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all( Radius.circular(35)),
                  child: Container(
                    color: context.read<LocaleCubit>().isDark? AppColors.white:AppColors.mirage,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GNav(
                        onTabChange:(value) {
                          cubit.onScreenChanged(value);
                        } ,
                        backgroundColor: context.read<LocaleCubit>().isDark? AppColors.white:AppColors.mirage,
                        color: context.read<LocaleCubit>().isDark? AppColors.mirage:AppColors.white,
                        activeColor: context.read<LocaleCubit>().isDark? AppColors.white:AppColors.mirage,
                        textStyle: textTheme.bodyMedium,
                        tabBackgroundColor:context.read<LocaleCubit>().isDark? AppColors.mirage:AppColors.white,
                        style: GnavStyle.google,
                        iconSize: 24,
                        padding: EdgeInsets.all(16),
                        tabs: [
                          GButton(
                            icon: Icons.home_outlined,
                            text: localize.translate('home'),
                          ),
                          GButton(
                            icon: Icons.question_mark_outlined,
                            text: localize.translate('quizzes'),
                          ),
                          GButton(
                            icon: (cubit.userData.isTeacher??false)? Icons.person_outlined : Icons.directions_run,
                            text: (cubit.userData.isTeacher??false)? localize.translate('attendance') : localize.translate('activity'),
                          ),
                          GButton(
                            icon: Icons.chat_outlined,
                            text: localize.translate('chat'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              body: PageView(
                controller: cubit.pageController,
                physics: (cubit.userData.isAdmin??false)? NeverScrollableScrollPhysics():BouncingScrollPhysics(),
                children: [
                  if(cubit.allEvents.isNotEmpty) HomeScreen() else Center(
                    child: Text(
                      localize.translate('no_events'),
                      style: textTheme.titleLarge,
                    ),
                  ),
                  if(state is OnSearchQuizOpenState || state is OnSearchQuizState) QuizSearch(quizzes: cubit.quizzesSearch, quizzesDone: cubit.quizzesDone,onChanged: (p0) => cubit.onSearchQuiz(p0),) else QuizzesScreen(quizzes: cubit.quizzes,quizzesDone: cubit.quizzesDone),
                  (cubit.userData.isTeacher??false) ?AttendanceScreen(attendanceList: cubit.attendance,userData: cubit.userData,):Text("Activity"),
                  ChatScreen()
                ],
                onPageChanged: (value) {
                  cubit.onValueChange(value);
                },
              ),
              drawer: CustomDrawer(),
            ),
      ),
    );
  }
}
