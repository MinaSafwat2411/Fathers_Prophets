import 'package:fathers_prophets/presentation/cubit/events/cubit/events_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/local/cubit/local_cubit.dart';
import 'package:fathers_prophets/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/event_shimmer_item.dart';
import '../../../data/models/events/events_model.dart';
import '../../cubit/events/states/events_states.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../cubit/layout/cubit/layout_cubit.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key, required this.title, required this.events});

  final String title;
  final List<EventsModel> events;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final localize = AppLocalizations.of(context);
    var cubit = LayoutCubit.get(context);
    return WillPopScope(
      onWillPop: () {
        context.read<LayoutCubit>().getAllData();
        context.pop();
        return Future.value(false);
      },
      child: BlocConsumer<EventsCubit, EventsStates>(
        builder:
            (context, state) => Scaffold(
              appBar: AppBar(
                title: Text(
                  localize.translate(title),
                  style: textTheme.titleLarge,
                ),
                leading: IconButton(
                  onPressed: () {
                    context.read<LayoutCubit>().getAllData();
                    context.pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                ),
              ),
              body:
                  events.isNotEmpty
                      ? Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemBuilder:
                                  (context, index) => GestureDetector(
                                    onTap:
                                        () async{
                                          var result = await context.pushNamed(
                                          AppRoutes.addEventAttendance.name,
                                          extra: {
                                            'title':title,
                                            'item':events[index],
                                          },
                                        );
                                          if(result != null){
                                            events[index] = result as EventsModel;
                                          }
                                        },
                                    child: Card(
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            child: events[index].image != ''?CachedNetworkImage(
                                              height: 200,
                                              width: double.infinity,
                                              fit: BoxFit.fill,
                                              imageUrl: events[index].image ?? '',
                                              placeholder:
                                                  (
                                                    context,
                                                    url,
                                                  ) => EventShimmerItem(
                                                    isDark:
                                                        context
                                                            .read<LocaleCubit>()
                                                            .isDark,
                                                  ),
                                              errorWidget:
                                                  (
                                                    context,
                                                    url,
                                                    error,
                                                  ) => EventShimmerItem(
                                                    isDark:
                                                        context
                                                            .read<LocaleCubit>()
                                                            .isDark,
                                                  ),
                                            ):Image.asset(context.read<LocaleCubit>().isDark?'assets/images/logo_dark.png': 'assets/images/logo_light.png',width: double.infinity,height: 200,fit: BoxFit.fill,),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "${events[index].title ?? ''} ${cubit.formatDateEvent(events[index].dateTime ?? DateTime.now(), context.read<LocaleCubit>().lang)}",
                                              style: textTheme.titleSmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              separatorBuilder:
                                  (context, index) => SizedBox(height: 0),
                              itemCount: events.length,
                            ),
                          ),
                        ],
                      )
                      : Center(
                        child: Text(
                          "${localize.translate('no_events')} ${localize.translate(title)}",
                          style: textTheme.titleLarge,
                        ),
                      ),
            ),
        listener: (context, state) {},
        buildWhen: (previous, current) => current is! InitialState,
      ),
    );
  }
}
