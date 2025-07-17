import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';

class EventAttendanceDetailsScreen extends StatelessWidget {
  const EventAttendanceDetailsScreen({super.key, required this.members});
  final List<String> members;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final localize = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localize.translate('event_attendance'),
          style: textTheme.titleLarge,
        ),
        leading: IconButton(onPressed: () {
          context.pop();
        },icon: Icon(Icons.arrow_back_ios_new_outlined),),
      ),
      body: members.isNotEmpty ?ListView.separated(
          itemBuilder: (context, index) => Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(members[index],style: textTheme.titleMedium,),
            ),
          ),
          separatorBuilder: (context, index) => SizedBox(),
          itemCount: members.length
      ):Center(
        child: Text(localize.translate('no_member_attended'),),
      ),
    );
  }
}
