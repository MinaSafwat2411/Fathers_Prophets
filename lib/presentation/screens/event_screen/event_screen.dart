import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/event_item.dart';
import '../../cubit/layout/cubit/layout_cubit.dart';
import '../../cubit/local/cubit/local_cubit.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LayoutCubit>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EventItem(
                  image:context.read<LocaleCubit>().isDark?"assets/images/ic_bible_dark.png":"assets/images/ic_bible_light.png" ,
                  title: 'bible',
                  isDark: context.read<LocaleCubit>().isDark,
                  events: cubit.bibleEvents,
                ),
                EventItem(
                  image:context.read<LocaleCubit>().isDark?"assets/images/ic_doctrine_dark.png":"assets/images/ic_doctrine_light.png" ,
                  title: 'doctrine',
                  isDark: context.read<LocaleCubit>().isDark,
                  events: cubit.doctrineEvents,
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EventItem(
                  image:context.read<LocaleCubit>().isDark?"assets/images/ic_coptic_dark.png":"assets/images/ic_coptic_light.png" ,
                  title: 'coptic',
                  isDark: context.read<LocaleCubit>().isDark,
                  events: cubit.copticEvents,
                ),
                EventItem(
                  image:context.read<LocaleCubit>().isDark?"assets/images/ic_choir_dark.png":"assets/images/ic_choir_light.png" ,
                  title: 'choir',
                  isDark: context.read<LocaleCubit>().isDark,
                  events: cubit.choirEvents,
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EventItem(
                  image:context.read<LocaleCubit>().isDark?"assets/images/ic_ritual_dark.png":"assets/images/ic_ritual_light.png" ,
                  title: 'ritual',
                  isDark: context.read<LocaleCubit>().isDark,
                  events: cubit.ritualEvents,
                ),
                EventItem(
                  image:context.read<LocaleCubit>().isDark?"assets/images/ic_melodies_dark.png":"assets/images/ic_melodies_light.png" ,
                  title: 'melodies',
                  isDark: context.read<LocaleCubit>().isDark,
                  events: cubit.melodiesEvents,
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EventItem(
                  image:context.read<LocaleCubit>().isDark?"assets/images/ic_pingpong_dark.png":"assets/images/ic_pingpong_light.png" ,
                  title: 'pingPong',
                  isDark: context.read<LocaleCubit>().isDark,
                  events: cubit.pingPongEvents,
                ),
                EventItem(
                  image:context.read<LocaleCubit>().isDark?"assets/images/ic_football_dark.png":"assets/images/ic_football_light.png" ,
                  title: 'football',
                  isDark: context.read<LocaleCubit>().isDark,
                  events: cubit.footballEvents,
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EventItem(
                  image:context.read<LocaleCubit>().isDark?"assets/images/ic_volleyball_dark.png":"assets/images/ic_volleyball_light.png" ,
                  title: 'volleyball',
                  isDark: context.read<LocaleCubit>().isDark,
                  events: cubit.volleyballEvents,
                ),
                EventItem(
                  image:context.read<LocaleCubit>().isDark?"assets/images/ic_chess_dark.png":"assets/images/ic_chess_light.png" ,
                  title: 'chess',
                  isDark: context.read<LocaleCubit>().isDark,
                  events: cubit.chessEvents,
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EventItem(
                  image:context.read<LocaleCubit>().isDark?"assets/images/ic_pray_dark.png":"assets/images/ic_pray_light.png" ,
                  title: 'pray',
                  isDark: context.read<LocaleCubit>().isDark,
                  events: cubit.prayEvents,
                ),
                EventItem(
                  image:context.read<LocaleCubit>().isDark?"assets/images/ic_praise_dark.png":"assets/images/ic_praise_light.png" ,
                  title: 'praise',
                  isDark: context.read<LocaleCubit>().isDark,
                  events: cubit.praiseEvents,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
