import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';

class QuizzesScoreTableScreen extends StatelessWidget {
  const QuizzesScoreTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var localize = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(localize.translate('quizzes_table')),
      ),
      body: const Center(
        child: Text('QuizzesScoreTableScreen'),
      ),
    );
  }
}
