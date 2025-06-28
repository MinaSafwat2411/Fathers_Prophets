import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../../data/models/quizzes/questions_model.dart';
import '../../../data/models/quizzes/quiz_answers.dart';

class QuizDayQuestions extends StatelessWidget {
  const QuizDayQuestions({super.key, required this.shahid, required this.dayLocalize, required this.questions, required this.function, this.answers});

  final String shahid;
  final String dayLocalize;
  final List<QuestionsModel> questions;
  final void Function(int parentIndex, int childIndex) function;
  final List<Answer>? answers;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var localize = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(localize.translate(dayLocalize), style: textTheme.titleLarge),
            SizedBox(height: 16),
            Text(
              shahid,
              style: textTheme.titleMedium,
            ),
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
                          Text(questions[parentIndex].question??"",style: textTheme.titleSmall,),
                          ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, childIndex) => Row(
                                children: [
                                  Checkbox(
                                    onChanged: (value) {
                                      function(parentIndex, childIndex);
                                    },
                                    value: answers?[parentIndex].answer==childIndex,
                                    activeColor: AppColors.green,
                                    shape: CircleBorder(),
                                  ),
                                  Text(questions[parentIndex].answers?[childIndex]??""),
                                  SizedBox(width: 5,),
                                ],
                              ),
                              separatorBuilder: (context, childIndex) => SizedBox(height: 5,),
                              itemCount: questions[parentIndex].answers?.length??0
                          )
                        ]
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, parentIndex) => SizedBox(height: 5),
              itemCount: questions.length,
            ),
          ],
        ),
      ),
    );
  }
}
