import 'package:fathers_prophets/presentation/cubit/events/cubit/events_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/events/states/events_states.dart';
import 'package:fathers_prophets/presentation/screens/select_member_screen/select_member_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';

class SelectMemberScreen extends StatelessWidget {
  const SelectMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context);
    var cubit = BlocProvider.of<EventsCubit>(context);
    return BlocConsumer<EventsCubit, EventsStates>(builder: (context, state) => Scaffold(
      appBar: AppBar(
        title: Text(localize.translate("select_member")),
        leading: IconButton(onPressed: () async{
          context.pop(
            cubit.selectedMembers
          );
        }, icon: Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                scrollDirection: Axis.horizontal,
                onPageChanged: (value) => cubit.currentIndex = value,
                children: [
                  SelectMemberItem(index: 0, className: cubit.classes.elementAt(0).name, members: cubit.getMembers(cubit.classes.elementAt(0).docId)),
                  SelectMemberItem(index: 1, className: cubit.classes.elementAt(1).name, members: cubit.getMembers(cubit.classes.elementAt(1).docId)),
                  SelectMemberItem(index: 2, className: cubit.classes.elementAt(2).name, members: cubit.getMembers(cubit.classes.elementAt(2).docId)),
                  SelectMemberItem(index: 3, className: cubit.classes.elementAt(3).name, members: cubit.getMembers(cubit.classes.elementAt(3).docId)),
                  SelectMemberItem(index: 4, className: cubit.classes.elementAt(4).name, members: cubit.getMembers(cubit.classes.elementAt(4).docId)),
                  SelectMemberItem(index: 5, className: cubit.classes.elementAt(5).name, members: cubit.getMembers(cubit.classes.elementAt(5).docId)),
                  SelectMemberItem(index: 6, className: cubit.classes.elementAt(6).name, members: cubit.getMembers(cubit.classes.elementAt(6).docId)),
                  SelectMemberItem(index: 7, className: cubit.classes.elementAt(7).name, members: cubit.getMembers(cubit.classes.elementAt(7).docId)),
                ],
              ),
            ),
          ],
        ),
      ),
    ), listener: (context, state) {

    },);
  }
}
