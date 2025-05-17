import 'package:fathers_prophets/core/utils/app_colors.dart';
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
                GestureDetector(
                  child: const Icon(Icons.search),
                  onTap: () {
                    context.pushNamed(AppRoutes.search.name);
                  },
                ),
              ],
              centerTitle: false,
              titleSpacing: 0,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton:
            (cubit.currentIndex != 0) && (cubit.userData.admin??false)
                ? Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: context.read<LocaleCubit>().isDark? AppColors.mirage:AppColors.white,
                borderRadius: BorderRadius.circular(55),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: () async {
                    switch (cubit.currentIndex) {
                      case 0: break;
                      case 1: break;
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
                          break;
                        }
                      }
                    }
                  },
                  child: const Icon(Icons.edit),
                ),
              ),
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
                      icon: Icons.person_outlined,
                      label: localize.translate('attendance'),
                    ),
                  ],
                ),
              ),
            ),
            body: PageView(
              controller: cubit.pageController,
              children: [
                Text("Home"),
                Text("Home"),
                QuizzesScreen(quizzes: cubit.quizzes,quizzesDone: cubit.quizzesDone),
                AttendanceScreen(attendanceList: cubit.attendance,),
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
