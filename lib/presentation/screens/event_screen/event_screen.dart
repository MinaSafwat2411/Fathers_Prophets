import 'package:fathers_prophets/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/event_item.dart';
import '../../cubit/local/cubit/local_cubit.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final localize = AppLocalizations.of(context);
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
                ),
                EventItem(
                  image:context.read<LocaleCubit>().isDark?"assets/images/ic_doctrine_dark.png":"assets/images/ic_doctrine_light.png" ,
                  title: 'doctrine',
                  isDark: context.read<LocaleCubit>().isDark
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
                  isDark: context.read<LocaleCubit>().isDark
                ),
                EventItem(
                  image:context.read<LocaleCubit>().isDark?"assets/images/ic_choir_dark.png":"assets/images/ic_choir_light.png" ,
                  title: 'choir',
                  isDark: context.read<LocaleCubit>().isDark
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
                  isDark: context.read<LocaleCubit>().isDark
                ),
                EventItem(
                  image:context.read<LocaleCubit>().isDark?"assets/images/ic_melodies_dark.png":"assets/images/ic_melodies_light.png" ,
                  title: 'melodies',
                  isDark: context.read<LocaleCubit>().isDark
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
                  isDark: context.read<LocaleCubit>().isDark
                ),
                EventItem(
                  image:context.read<LocaleCubit>().isDark?"assets/images/ic_football_dark.png":"assets/images/ic_football_light.png" ,
                  title: 'football',
                  isDark: context.read<LocaleCubit>().isDark
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
                  isDark: context.read<LocaleCubit>().isDark
                ),
                EventItem(
                  image:context.read<LocaleCubit>().isDark?"assets/images/ic_chess_dark.png":"assets/images/ic_chess_light.png" ,
                  title: 'chess',
                  isDark: context.read<LocaleCubit>().isDark
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
