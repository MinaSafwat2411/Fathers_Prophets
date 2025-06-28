import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/event_shimmer_item.dart';
import '../../../data/models/events/events_model.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import '../../routes.dart';

class HomeScreenItem extends StatelessWidget {
  const HomeScreenItem({super.key, required this.events, required this.title});
  final List<EventsModel> events;
  final String title;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final localize = AppLocalizations.of(context);
    return events.isNotEmpty ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(AppRoutes.eventDetails.name,
                extra: {
                  'items': events,
                  'title': title,
                });
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(localize.translate(title), style: textTheme.titleLarge),
          ),
        ),
        SizedBox(
          height: 230,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder:
                (context, index) => GestureDetector(
                  onTap: () {
                    context.pushNamed(AppRoutes.addEventAttendance.name,
                        extra: {
                          'item': events[index],
                          'title': title,
                        });
                  },
                  child: Card(
                                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        height: 180,
                        width: 230,
                        fit: BoxFit.fill,
                        imageUrl: events[index].image ?? '',
                        placeholder:
                            (context, url) => EventShimmerItem(
                          isDark: context.read<LocaleCubit>().isDark,
                        ),
                        errorWidget:
                            (context, url, error) => EventShimmerItem(
                          isDark: context.read<LocaleCubit>().isDark,
                        ),
                      ),
                    ),
                    Text(events[index].title ?? ""),
                  ],
                                ),
                              ),
                ),
            separatorBuilder: (context, index) => SizedBox(),
            itemCount: events.length > 3 ? 3 : events.length,
          ),
        ),
      ],
    ) :SizedBox();
  }
}
