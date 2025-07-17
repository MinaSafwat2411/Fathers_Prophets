import 'package:fathers_prophets/core/utils/app_colors.dart';
import 'package:fathers_prophets/core/widgets/custom_button.dart';
import 'package:fathers_prophets/data/models/quizzes/quizzes_model.dart';
import 'package:fathers_prophets/presentation/cubit/quizzes/cubit/quizzes_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/quizzes/states/quizzes_states.dart';
import 'package:fathers_prophets/presentation/screens/quizzes_details_screen/quiz_day_questions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/custom_snackbar.dart';

class QuizzesDetailsScreen extends StatelessWidget {
  const QuizzesDetailsScreen({super.key, required this.quizzes,required this.query});

  final QuizzesModel quizzes;
  final Map<String,String> query;

  @override
  Widget build(BuildContext context) {
    final isAddMode = query['mode'] == 'add';
    var localize = AppLocalizations.of(context);
    var cubit = BlocProvider.of<QuizzesCubit>(context)..createQuizAnswers(quizzes.docId??"",quizzes);
    cubit.isAdd = isAddMode;
    var textTheme = Theme.of(context).textTheme;
    return BlocConsumer<QuizzesCubit,QuizzesStates>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            cubit.onSaveAnswers();
          }, icon: Icon(Icons.arrow_back_ios)),
          title: Text("${localize.translate("quiz_no")} ${quizzes.number}",
            style: textTheme.titleLarge,
          ),
        ),
        body: PageView(
          children: [
            QuizDayQuestions(dayLocalize: "friday",function:isAddMode?(parentIndex, childIndex){} :(parentIndex, childIndex) => cubit.updateQuizAnswers(parentIndex, childIndex, "Friday"),
              questions: quizzes.friday?.questions??[],
              shahid: quizzes.friday?.shahid??"",
              answers: cubit.quizAnswers.friday?.answers?? [],
            ),
            QuizDayQuestions(dayLocalize: "saturday",function:isAddMode?(parentIndex, childIndex){} :(parentIndex, childIndex) => cubit.updateQuizAnswers(parentIndex, childIndex, "Saturday"),
              questions: quizzes.saturday?.questions??[],
              shahid: quizzes.saturday?.shahid??"",
              answers: cubit.quizAnswers.saturday?.answers?? [],
            ),
            QuizDayQuestions(dayLocalize: "sunday",function:isAddMode?(parentIndex, childIndex){} :(parentIndex, childIndex) => cubit.updateQuizAnswers(parentIndex, childIndex, "Sunday"),
              questions: quizzes.sunday?.questions??[],
              shahid: quizzes.sunday?.shahid??"",
              answers: cubit.quizAnswers.sunday?.answers?? [],
            ),
            QuizDayQuestions(dayLocalize: "monday",function:isAddMode?(parentIndex, childIndex){} :(parentIndex, childIndex) => cubit.updateQuizAnswers(parentIndex, childIndex, "Monday"),
              questions: quizzes.monday?.questions??[],
              shahid: quizzes.monday?.shahid??"",
              answers: cubit.quizAnswers.monday?.answers?? [],
            ),
            QuizDayQuestions(dayLocalize: "tuesday",function:isAddMode?(parentIndex, childIndex){} :(parentIndex, childIndex) => cubit.updateQuizAnswers(parentIndex, childIndex, "Tuesday"),
              questions: quizzes.tuesday?.questions??[],
              shahid: quizzes.tuesday?.shahid??"",
              answers: cubit.quizAnswers.tuesday?.answers?? [],
            ),
            QuizDayQuestions(dayLocalize: "wednesday",function:isAddMode?(parentIndex, childIndex){} :(parentIndex, childIndex) => cubit.updateQuizAnswers(parentIndex, childIndex, "Wednesday"),
              questions: quizzes.wednesday?.questions??[],
              shahid: quizzes.wednesday?.shahid??"",
              answers: cubit.quizAnswers.wednesday?.answers?? [],
            ),
            QuizDayQuestions(dayLocalize: "thursday",function:isAddMode?(parentIndex, childIndex){} :(parentIndex, childIndex) => cubit.updateQuizAnswers(parentIndex, childIndex, "Thursday"),
              questions: quizzes.thursday?.questions??[],
              shahid: quizzes.thursday?.shahid??"",
              answers: cubit.quizAnswers.thursday?.answers?? [],
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomButton(
            height: 56,
            btnColor: AppColors.green,
            text: localize.translate("submit"),
            isEnabled: true,
            onPressed: () {
              if(isAddMode){
                cubit.onAddQuiz();
              }else{
                cubit.onSubmit();
              }
            },
            isDark: false,
          ),
        ),
      ),
      listener: (context, state) {
        if(state is OnGetBack){
          context.pop(false);
        }
        if(state is OnSubmit){
          showCustomSnackBar(context, "Your Score is ${cubit.score}", icon: Icons.error, color: AppColors.red);
          context.pop(true);
        }
        if(state is OnError){
          showCustomSnackBar(context, state.error, icon: Icons.error, color: AppColors.red);
        }
        if(state is OnClose){
          context.pop(cubit.quiz);
        }
      },
      listenWhen: (previous, current) => current is OnGetBack || current is OnSubmit  ||current is OnClose,
    );
  }
}
