import 'package:fathers_prophets/core/utils/app_colors.dart';
import 'package:fathers_prophets/presentation/cubit/local/cubit/local_cubit.dart';
import 'package:fathers_prophets/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/event_shimmer_item.dart';
import '../../../data/models/events/events_model.dart';
import 'package:cached_network_image/cached_network_image.dart';


class EventDetails extends StatelessWidget {
  const EventDetails({super.key, required this.title, required this.events});

  final String title;
  final List<EventsModel> events;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final localize = AppLocalizations.of(context);
    return WillPopScope(
      onWillPop: () {
        context.pop();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            localize.translate(title),
            style: textTheme.titleLarge,
          ),
          leading: IconButton(
            onPressed: () {
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
                  child: Stack(
                    alignment: context.read<LocaleCubit>().lang == 'ar' ? Alignment.centerLeft:Alignment.centerRight,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: context.read<LocaleCubit>().isDark? AppColors.mirage:AppColors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: context.read<LocaleCubit>().isDark? AppColors.white:AppColors.mirage)
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    16,
                                  ),
                                  child: events[index].image != ''?CachedNetworkImage(
                                    height: 75,
                                    width: 70,
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
                                  ):Image.asset(context.read<LocaleCubit>().isDark?'assets/images/logo_dark.png': 'assets/images/logo_light.png',width: 70,height: 70,fit: BoxFit.fill,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${events[index].nameAr ?? ''} ${formatDateEvent(events[index].dateTime ?? DateTime.now(), context.read<LocaleCubit>().lang)}",
                                    style: textTheme.titleSmall,
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: context.read<LocaleCubit>().isDark? AppColors.mirage : AppColors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: context.read<LocaleCubit>().isDark? AppColors.white:AppColors.mirage)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(Icons.arrow_forward_ios_outlined,size: 16,),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                separatorBuilder:
                    (context, index) => SizedBox(height: 5),
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
    );
  }
  static String formatDateEvent(DateTime dateTime, String lang) {
    String locale = lang == "en" ? "en_US" : "ar_SA";
    DateFormat dateFormat = DateFormat("EEEE d - MMM", locale);
    return dateFormat.format(dateTime);
  }
}
