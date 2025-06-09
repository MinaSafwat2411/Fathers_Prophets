import 'package:fathers_prophets/presentation/cubit/events/cubit/events_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/local/cubit/local_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/event_shimmer_item.dart';
import '../../../data/models/events/events_model.dart';
import '../../cubit/events/states/events_states.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key, required this.title, required this.events});

  final String title;
  final List<EventsModel> events;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final localize = AppLocalizations.of(context);
    var cubit = BlocProvider.of<EventsCubit>(context);
    return BlocConsumer<EventsCubit, EventsStates>(
      builder: (context, state) =>  Scaffold(
        appBar: AppBar(
          title: Text(localize.translate(title), style: textTheme.titleLarge),
        ),
        body:events.isNotEmpty? Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder:
                    (context, index) => Card(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: events[index].image ?? '',
                          placeholder: (context, url) =>
                              EventShimmerItem(isDark: context.read<LocaleCubit>().isDark),
                          errorWidget: (context, url, error) =>
                              EventShimmerItem(isDark: context.read<LocaleCubit>().isDark),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          events[index].title ?? '',
                          style: textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: events.length,
              ),
            ),
          ],
        ): Center(
          child: Text(localize.translate('no_events'), style: textTheme.titleLarge),
        ),
      ),
      listener: (context, state) {
      },
      buildWhen: (previous, current) => current is! InitialState,
    );
  }
}
