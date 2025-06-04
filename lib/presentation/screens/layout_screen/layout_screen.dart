import 'package:fathers_prophets/presentation/cubit/add_attendance/cubit/add_attendance_cubit.dart';
import 'package:fathers_prophets/presentation/screens/event_screen/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../../core/widgets/custom_drawer.dart';
import '../../../data/models/attendance/attendance_model.dart';
import '../../../data/models/quizzes/quizzes_model.dart';
import '../../cubit/layout/cubit/layout_cubit.dart';
import '../../cubit/layout/states/layout_states.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import '../../routes.dart';
import '../attendance_screen/attendance_screen.dart';
import '../event_screen/event_search.dart';
import '../quizzes_screen/quiz_search.dart';
import '../quizzes_screen/quizzes_screen.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = LayoutCubit.get(context);
    final localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    return BlocConsumer<LayoutCubit, LayoutStates>(
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
                  child: Image.asset(
                    context.read<LocaleCubit>().isDark
                        ? "assets/images/logo_dark.png"
                        : "assets/images/logo_light.png",
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
                    context.pushNamed(AppRoutes.notifications.name);
                  },
                ),
              ]
                  : cubit.currentIndex == 3
                  ? null
                  : [
                    if(state is OnSearchEventOpenState || state is OnSearchQuizOpenState || state is OnSearchQuizState || state is OnSearchEventState)GestureDetector(
                      child: const Icon(Icons.close),
                      onTap: () {
                        switch (cubit.currentIndex) {
                          case 0: break;
                          case 1:
                            {
                              cubit.onSearchEventCloseClicked();
                            }
                          case 2:
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
                          cubit.onSearchEventClicked();
                        }
                      case 2:
                        {
                          cubit.onSearchQuizClicked();
                        }
                    }
                  },
                )
              ],
              centerTitle: false,
              titleSpacing: 0,
            ),
            floatingActionButton:
            (cubit.currentIndex != 0) && (cubit.userData.admin??false)
                ? FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: () async {
                    switch (cubit.currentIndex) {
                      case 0: break;
                      case 1: {
                        var event = await context.pushNamed(AppRoutes.addEvent.name);
                        if(event == null) {
                          return;
                        } else {
                          break;
                        }
                      }
                      case 2:
                        {
                          var quiz = await context.pushNamed(AppRoutes.addQuiz.name);
                          if(quiz == null) {
                            return;
                          } else {
                            cubit.quizzes.add(quiz as QuizzesModel);
                            cubit.sortQuizzes();
                          }
                          break;
                        }
                      case 3: {
                        var attendance = await context.pushNamed(AppRoutes.addAttendance.name);
                        if(attendance == null) {
                          return ;
                        } else {
                          cubit.attendance.add(attendance as AttendanceModel);
                          cubit.sortAttendance();
                          context.read<AddAttendanceCubit>().onRest();
                          break;
                        }
                      }
                    }
                  },
                  child: const Icon(Icons.edit),
                )
                : null,
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, bottom: 8.0, right: 8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: BottomNavigationBar(
                  onTap: (value) {
                    cubit.onScreenChanged(value);
                  },
                  currentIndex: cubit.currentIndex,
                  items: [
                    CustomBottomNavigationBarItem.create(
                      icon: Icons.home_outlined,
                      label: localize.translate('home'),
                    ),
                    CustomBottomNavigationBarItem.create(
                      icon: Icons.event_available_outlined,
                      label: localize.translate('event'),
                    ),
                    CustomBottomNavigationBarItem.create(
                      icon: Icons.question_mark_outlined,
                      label: localize.translate('quizzes'),
                    ),
                    CustomBottomNavigationBarItem.create(
                      icon: (cubit.userData.isTeacher?? false)?  Icons.person_outlined : Icons.directions_run,
                      label: (cubit.userData.isTeacher?? false)? localize.translate('attendance') : localize.translate('activity'),
                    ),
                  ],
                ),
              ),
            ),
            body: PageView(
              controller: cubit.pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Text("Home"),
                if(state is OnSearchEventOpenState ||state is OnSearchEventState) EventSearch(onChanged: (p0) => cubit.onSearchEvent(p0),)else EventScreen(),
                if(state is OnSearchQuizOpenState || state is OnSearchQuizState) QuizSearch(quizzes: cubit.quizzesSearch, quizzesDone: cubit.quizzesDone,onChanged: (p0) => cubit.onSearchQuiz(p0),) else QuizzesScreen(quizzes: cubit.quizzes,quizzesDone: cubit.quizzesDone),
                (cubit.userData.isTeacher??false) ?AttendanceScreen(attendanceList: cubit.attendance,userData: cubit.userData,):Text("Activity"),
              ],
              onPageChanged: (value) {
                cubit.onValueChange(value);
              },
            ),
            drawer: CustomDrawer(),
          ),
    );
  }
}
