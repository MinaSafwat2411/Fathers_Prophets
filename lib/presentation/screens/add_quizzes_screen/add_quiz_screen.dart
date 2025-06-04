import 'package:fathers_prophets/core/utils/app_colors.dart';
import 'package:fathers_prophets/core/widgets/custom_big_textfield.dart';
import 'package:fathers_prophets/core/widgets/custom_button.dart';
import 'package:fathers_prophets/presentation/cubit/quizzes/cubit/quizzes_cubit.dart';
import 'package:fathers_prophets/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../../data/models/bible/bible_model.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import '../../cubit/quizzes/states/quizzes_states.dart';
import 'day_enum.dart';

class AddQuizScreen extends StatelessWidget {
  const AddQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    var cubit = context.read<QuizzesCubit>();
    return BlocConsumer<QuizzesCubit, QuizzesStates>(
      builder:
          (context, state) => Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  cubit.onRestAll();
                  context.pop(null);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              actions: [
                TextButton(
                  onPressed: () => cubit.onReview(),
                  child: Text(
                    localize.translate('save'),
                    style: textTheme.titleSmall,
                  ),
                ),
              ],
              title: Text(localize.translate("add_quiz")),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownMenu(
                      inputDecorationTheme: InputDecorationTheme(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.azureRadiance)
                        )
                      ),
                      dropdownMenuEntries: [
                        DropdownMenuEntry<DayEnum>(
                          value: DayEnum.FRIDAY,
                          label: localize.translate("friday"),
                        ),
                        DropdownMenuEntry<DayEnum>(
                          value: DayEnum.SATURDAY,
                          label: localize.translate("saturday"),
                        ),
                        DropdownMenuEntry<DayEnum>(
                          value: DayEnum.SUNDAY,
                          label: localize.translate("sunday"),
                        ),
                        DropdownMenuEntry<DayEnum>(
                          value: DayEnum.MONDAY,
                          label: localize.translate("monday"),
                        ),
                        DropdownMenuEntry<DayEnum>(
                          value: DayEnum.TUESDAY,
                          label: localize.translate("tuesday"),
                        ),
                        DropdownMenuEntry<DayEnum>(
                          value: DayEnum.WEDNESDAY,
                          label: localize.translate("wednesday"),
                        ),
                        DropdownMenuEntry<DayEnum>(
                          value: DayEnum.THURSDAY,
                          label: localize.translate("thursday"),
                        ),
                      ],
                      onSelected: (value) {
                        cubit.onSelectDate(value!);
                      },
                      width: double.infinity,
                      hintText: localize.translate("select_day"),
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
                          )
                      ),
                      enabled: cubit.selectedDate.isNotEmpty,
                      dropdownMenuEntries: [
                        DropdownMenuEntry<bool>(
                          value: true,
                          label: localize.translate("old_testament"),
                        ),
                        DropdownMenuEntry<bool>(
                          value: false,
                          label: localize.translate("new_testament"),
                        ),
                      ],
                      onSelected: (value) {
                        cubit.onOldOrNewTestament(value ?? false);
                      },
                      width: double.infinity,
                      menuHeight: 300,
                      hintText: localize.translate("select_testament"),
                      menuStyle: MenuStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (cubit.isOldTestament??false)
                          Expanded(
                            child: DropdownMenu(
                              inputDecorationTheme: InputDecorationTheme(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: AppColors.azureRadiance)
                                  )
                              ),
                              enabled: cubit.isOldTestament??false,
                              dropdownMenuEntries: [
                                for (
                                  int i = 0;
                                  i < cubit.oldTestamentBooks.length;
                                  i++
                                )
                                  DropdownMenuEntry<BibleModel>(
                                    value: cubit.oldTestamentBooks[i],
                                    label: cubit.oldTestamentBooks[i].name,
                                  ),
                              ],
                              onSelected: (value) {
                                cubit.onSelectTestament(
                                  value ?? BibleModel(name: "", chapters: 0),
                                );
                              },
                              width: double.infinity,
                              menuHeight: 300,
                              hintText: localize.translate("select_book"),
                              menuStyle: MenuStyle(
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          )
                        else
                        Expanded(
                            child: DropdownMenu(
                              inputDecorationTheme: InputDecorationTheme(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: AppColors.azureRadiance)
                                  )
                              ),
                              dropdownMenuEntries: [
                                for (
                                  int i = 0;
                                  i < cubit.newTestamentBooks.length;
                                  i++
                                )
                                  DropdownMenuEntry<BibleModel>(
                                    value: cubit.newTestamentBooks[i],
                                    label: cubit.newTestamentBooks[i].name,
                                  ),
                              ],
                              enabled: cubit.isOldTestament??false,
                              onSelected: (value) {
                                cubit.onSelectTestament(
                                  value ?? BibleModel(name: "", chapters: 0),
                                );
                              },
                              width: double.infinity,
                              menuHeight: 300,
                              hintText: localize.translate("select_book"),
                              menuStyle: MenuStyle(
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        SizedBox(width: 5),
                        Expanded(
                          child: DropdownMenu(
                            inputDecorationTheme: InputDecorationTheme(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: AppColors.azureRadiance)
                                )
                            ),
                            enabled: cubit.selectedTestamentItem.name.isNotEmpty,
                            dropdownMenuEntries: [
                              for (
                                int i = 0;
                                i < cubit.selectedTestamentItem.chapters;
                                i++
                              )
                                DropdownMenuEntry<int>(
                                  value: i + 1,
                                  label: "${i + 1}",
                                ),
                            ],
                            onSelected: (value) {
                              cubit.onChapter(value.toString());
                            },
                            width: double.infinity,
                            menuHeight: 300,
                            hintText: localize.translate("select_chapter"),
                            menuStyle: MenuStyle(
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: CustomBigTextField(
                            controller: cubit.fromController,
                            isDark: context.read<LocaleCubit>().isDark,
                            observe: false,
                            label: localize.translate("from"),
                            onChanged: (p0) => cubit.onAddedVerse(),
                            keyboardType: TextInputType.number,
                            enable: cubit.chapter.isNotEmpty,
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: CustomBigTextField(
                            controller: cubit.toController,
                            isDark: context.read<LocaleCubit>().isDark,
                            observe: false,
                            label: localize.translate("to"),
                            onChanged: (p0) => cubit.onAddedVerse(),
                            keyboardType: TextInputType.number,
                            enable: cubit.chapter.isNotEmpty,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${localize.translate(cubit.selectedDate)}\n${cubit.selectedTestament} ${cubit.chapter} (${cubit.from} - ${cubit.to})",
                          style: textTheme.titleLarge,
                        ),
                        Spacer(),
                        Text(
                          "${cubit.noOfQuestionsChanged(cubit.selectedDate)} / 5",
                          style: textTheme.titleLarge,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder:
                          (context, parentIndex) => Card(
                            child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          cubit
                                                  .questions[parentIndex]
                                                  .question ??
                                              "",
                                          style: textTheme.titleSmall,
                                        ),
                                        Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            cubit.onDeleteQuestion(parentIndex);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: AppColors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (context, childIndex) => Row(
                                            children: [
                                              Checkbox(
                                                onChanged: (value) {},
                                                value:
                                                    cubit
                                                        .questions[parentIndex]
                                                        .correctAnswer ==
                                                    childIndex,
                                                activeColor: AppColors.green,
                                                shape: CircleBorder(),
                                              ),
                                              Text(
                                                cubit
                                                        .questions[parentIndex]
                                                        .answers?[childIndex] ??
                                                    "",
                                              ),
                                              SizedBox(width: 5),
                                            ],
                                          ),
                                      separatorBuilder:
                                          (context, childIndex) =>
                                              SizedBox(height: 5),
                                      itemCount:
                                          cubit
                                              .questions[parentIndex]
                                              .answers
                                              ?.length ??
                                          0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      separatorBuilder:
                          (context, parentIndex) => SizedBox(height: 5),
                      itemCount: cubit.questions.length,
                    ),
                    SizedBox(height: 10),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder:
                          (context, index) => Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      if (index != 0)
                                        Checkbox(
                                          onChanged: (value) {
                                            cubit.onCorrectAnswer(index);
                                          },
                                          value: cubit.correctAnswer[index],
                                          activeColor: AppColors.green,
                                          shape: CircleBorder(),
                                        ),
                                      Text(
                                        cubit.question[index],
                                        style: textTheme.titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.onDeleteAnswer(index);
                                },
                                icon: Icon(Icons.delete, color: AppColors.red),
                              ),
                            ],
                          ),
                      separatorBuilder: (context, index) => SizedBox(height: 5),
                      itemCount: cubit.question.length,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 3),
                    CustomBigTextField(
                      controller: cubit.controller,
                      isDark: context.read<LocaleCubit>().isDark,
                      enable: cubit.question.length < 5,
                      observe: false,
                      label:
                          cubit.question.isEmpty
                              ? localize.translate("question")
                              : localize.translate("answer"),
                      onChanged: (p0) => cubit.onQuestionControllerChanged(),
                      icon: SizedBox(
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: AppColors.azureRadiance,
                            size: 24,
                          ),
                          onPressed: () {
                            cubit.onAddAnswer();
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomButton(
                      onPressed: () => cubit.onAddQuestion(),
                      text: localize.translate("add_question"),
                      isEnabled:
                          cubit.selectedDate != '' &&
                          cubit.question.length >= 3,
                      btnColor: AppColors.azureRadiance,
                      height: 56,
                      isDark: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
      listener: (context, state) async {
        switch(state){
          case OnLimitQuestions() :showCustomSnackBar(
            context,
            localize.translate("max_questions"),
            icon: Icons.error,
            color: AppColors.red,
          );
          case OnError() :showCustomSnackBar(
            context,
            localize.translate(state.error),
            icon: Icons.error,
            color: AppColors.red,
          );
          case OnReview():{
            var isAdd = await context.pushNamed(
              AppRoutes.quizDetails.name,
              extra: cubit.quiz,
              queryParameters: {'mode': 'add'},
            );
            if (isAdd == null) {
              return;
            } else {
              context.pop(cubit.quiz);
            }
          }
        }
      },
      buildWhen: (previous, current) => current is! InitialState,
    );
  }
}
