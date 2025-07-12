import 'package:fathers_prophets/core/utils/app_colors.dart';
import 'package:fathers_prophets/core/widgets/custom_big_textfield.dart';
import 'package:fathers_prophets/core/widgets/custom_button.dart';
import 'package:fathers_prophets/core/widgets/custom_loading.dart';
import 'package:fathers_prophets/core/widgets/custom_snackbar.dart';
import 'package:fathers_prophets/data/models/classes/class_model.dart';
import 'package:fathers_prophets/data/models/classes/class_user_model.dart';
import 'package:fathers_prophets/presentation/cubit/local/cubit/local_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/quiz_table/cubit/quiz_table_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../data/models/quizzes/quizzes_model.dart';
import '../../cubit/quiz_table/states/quiz_table_states.dart';

class QuizzesScoreTableScreen extends StatelessWidget {
  const QuizzesScoreTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context);
    var cubit = QuizTableCubit.get(context);
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<QuizTableCubit, QuizTableStates>(
      builder:
          (context, state) => Stack(
            alignment: Alignment.center,
            children: [
              Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(localize.translate('quizzes_table')),
                  leading: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  ),
                ),
                body: PageView(
                  children: [
                    RefreshIndicator(
                      onRefresh: () async {
                        cubit.getAllQuizzesScore();
                      },
                      child:
                          cubit.quizzesScore.isEmpty
                              ? ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                children: [
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.4,
                                  ),
                                  Center(
                                    child: Text(
                                      localize.translate('no_member_done_quiz'),
                                    ),
                                  ),
                                ],
                              )
                              : ListView.builder(
                                padding: const EdgeInsets.all(8.0),
                                physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics(),
                                ),
                                itemCount: cubit.quizzesScore.length,
                                itemBuilder:
                                    (context, i) => Card(
                                      margin: EdgeInsets.zero,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              cubit.quizzesScore[i].name ?? "",
                                              style: textTheme.titleMedium,
                                            ),
                                            Text(
                                              cubit.quizzesScore[i].score
                                                  .toString(),
                                              style: textTheme.titleMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownMenu(
                              inputDecorationTheme: InputDecorationTheme(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: AppColors.azureRadiance)
                                  )
                              ),
                              dropdownMenuEntries: cubit.classes.map((e) => DropdownMenuEntry<ClassModel>(
                                value: e,
                                label: e.name??"",
                              )).toList(),
                              onSelected: (value) {
                                cubit.onClassSelected(value??ClassModel());
                              },
                              width: double.infinity,
                              menuHeight: 300,
                              hintText: localize.translate("select_class"),
                              menuStyle: MenuStyle(
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            DropdownMenu(
                              inputDecorationTheme: InputDecorationTheme(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: AppColors.azureRadiance)
                                  ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: AppColors.azureRadiance)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: AppColors.azureRadiance)
                                )
                              ),
                              dropdownMenuEntries: (cubit.selectedClass.members??[]).map((e) => DropdownMenuEntry<ClassUserModel>(
                                value: e,
                                label: e.name??"",
                              )).toList(),
                              requestFocusOnTap: true,
                              onSelected: (value) {
                                cubit.onSelectMember(value??ClassUserModel());
                              },
                              width: double.infinity,
                              hintText: localize.translate("select_member"),
                              menuHeight: 300,
                              enableSearch: true,
                              controller: cubit.nameController,
                              enableFilter: true,
                              menuStyle: MenuStyle(
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            DropdownMenu(
                              inputDecorationTheme: InputDecorationTheme(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: AppColors.azureRadiance)
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: AppColors.azureRadiance)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: AppColors.azureRadiance)
                                  )
                              ),
                              dropdownMenuEntries: [
                                for (var quiz in cubit.quizzes) DropdownMenuEntry<QuizzesModel>(
                                  value: quiz,
                                  label: "${localize.translate("quiz_no")} ${quiz.number}",
                                )
                              ],
                              requestFocusOnTap: true,
                              onSelected: (value) {
                                cubit.onSelectQuiz(value as QuizzesModel);
                              },
                              width: double.infinity,
                              hintText: localize.translate("select_quiz"),
                              menuHeight: 300,
                              enableSearch: true,
                              controller: cubit.quizNumberController,
                              enableFilter: true,
                              menuStyle: MenuStyle(
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            CustomBigTextField(
                                controller: cubit.scoreController,
                                label: localize.translate('score'),
                                isDark: context.read<LocaleCubit>().isDark,
                                observe: false,
                                keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 10),
                            CustomButton(
                                onPressed: () => cubit.addQuizzesScore(),
                                text: localize.translate('add'),
                                isEnabled: cubit.selectedMember.name != null && cubit.selectedQuiz.number != null && cubit.scoreController.text.isNotEmpty && cubit.selectedClass.docId!=null && cubit.selectedMember.name!.isNotEmpty && int.parse(cubit.scoreController.text)>0,
                                btnColor: AppColors.green,
                                height: 56,
                                isDark: context.read<LocaleCubit>().isDark,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (state is OnLoading)
                CustomLoading(isDark: context.read<LocaleCubit>().isDark),
            ],
          ),
      listener: (context, state) {
        if (state is OnError) {
          showCustomSnackBar(
            context,
            state.error,
            color: AppColors.red,
            icon: Icons.error_outline,
          );
        }
      },
    );
  }
}
