import 'package:fathers_prophets/core/utils/app_colors.dart';
import 'package:fathers_prophets/core/widgets/custom_loading.dart';
import 'package:fathers_prophets/core/widgets/custom_snackbar.dart';
import 'package:fathers_prophets/presentation/cubit/local/cubit/local_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/quiz_table/cubit/quiz_table_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
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
        body: RefreshIndicator(
          onRefresh: () async {
            cubit.getAllQuizzesScore();
          },
          child: cubit.quizzesScore.isEmpty
              ? ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.4),
              Center(
                child: Text(localize.translate('no_member_done_quiz')),
              ),
            ],
          )
              : ListView.builder(
            padding: const EdgeInsets.all(8.0),
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: cubit.quizzesScore.length,
            itemBuilder: (context, i) => Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cubit.quizzesScore[i].name ?? "",
                      style: textTheme.titleMedium,
                    ),
                    Text(
                      cubit.quizzesScore[i].score.toString(),
                      style: textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
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
