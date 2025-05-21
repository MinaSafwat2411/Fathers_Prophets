import 'package:fathers_prophets/data/models/quizzes/quizzes_model.dart';
import 'package:fathers_prophets/presentation/cubit/layout/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../routes.dart';

class QuizzesScreen extends StatelessWidget {
  const QuizzesScreen({super.key, required this.quizzes, required this.quizzesDone});

  final List<QuizzesModel> quizzes;
  final List<String> quizzesDone;


  @override
  Widget build(BuildContext context) {
    var localize = AppLocalizations.of(context);
    var cubit = context.read<LayoutCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
              bool isChecked = quizzesDone.contains(quizzes[index].docId);
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () async{
                        if(!isChecked) {
                          var  quiz = await context.pushNamed(AppRoutes.quizDetails.name,extra: quizzes[index]);
                          if(quiz as bool){
                            cubit.afterUpdateQuizzes();
                          }
                        }
                      },
                      child: Card(
                      child: SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                               "${localize.translate("quiz_no")} ${quizzes[index].number}",
                              ),
                            ),
                            Checkbox(
                              value: isChecked,
                              onChanged: (value) {},
                              activeColor: AppColors.green,
                            ),
                          ],
                        ),
                      ),
                                    ),
                    ),
                    if(index == quizzes.length-1)SizedBox(height: 30,)
                  ],
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 5,),
              itemCount: quizzes.length
          ),
        ],
      ),
    );
  }
}
