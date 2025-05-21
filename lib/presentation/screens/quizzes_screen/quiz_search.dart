import 'package:fathers_prophets/presentation/screens/quizzes_screen/quizzes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../../data/models/quizzes/quizzes_model.dart';
import '../../cubit/local/cubit/local_cubit.dart';

class QuizSearch extends StatelessWidget {
  const QuizSearch({super.key, this.onChanged, required this.quizzes, required this.quizzesDone, this.controller});

  final void Function(String)? onChanged;
  final List<QuizzesModel> quizzes;
  final List<String> quizzesDone;
  final TextEditingController? controller;


  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SearchBar(
            onChanged: onChanged,
            hintText: localize.translate('search'),
            leading: Icon(Icons.search,color: context.read<LocaleCubit>().isDark ? AppColors.mirage:AppColors.white),
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(8),
            ),
            controller: controller,
            elevation: MaterialStateProperty.all<double>(2),
            keyboardType: TextInputType.number,
            textStyle: WidgetStatePropertyAll(TextStyle(color: context.read<LocaleCubit>().isDark ? AppColors.mirage:AppColors.white)),
            backgroundColor: WidgetStatePropertyAll(context.read<LocaleCubit>().isDark ? AppColors.white:AppColors.mirage),
            hintStyle: WidgetStatePropertyAll(TextStyle(color: context.read<LocaleCubit>().isDark ? AppColors.mirage:AppColors.white)),
          ),
        ),
        QuizzesScreen(
          quizzes: quizzes,
          quizzesDone: quizzesDone,
        ),
      ],
    );
  }
}
