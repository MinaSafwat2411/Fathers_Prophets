import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/event_shimmer_item.dart';
import '../../../data/models/events/events_model.dart';
import '../../cubit/layout/cubit/layout_cubit.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import '../../routes.dart';

class EventSearch extends StatelessWidget {
  const EventSearch({
    super.key,
    required this.events,
  });

  final List<EventsModel> events;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var cubit = LayoutCubit.get(context);
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      shrinkWrap: true,
      itemCount: events.length,
      itemBuilder: (context, index) => AspectRatio(
        aspectRatio: 0.75, // Adjust as needed
        child: GestureDetector(
          onTap: () async{
            var result = await context.pushNamed(AppRoutes.addEventAttendance.name,
                extra: {
                  'item': events[index],
                  'title': events[index].nameEn,
                });
            if(result != null){
              cubit.getAllData();
            }
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                events[index].image != '' ?CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  imageUrl: events[index].image ?? '',
                  placeholder: (context, url) => EventShimmerItem(
                    isDark: context.read<LocaleCubit>().isDark,
                  ),
                  errorWidget: (context, url, error) => EventShimmerItem(
                    isDark: context.read<LocaleCubit>().isDark,
                  ),
                ):Image.asset(
                  context.read<LocaleCubit>().isDark
                      ? "assets/images/logo_dark.png"
                      : "assets/images/logo_light.png",
                  height: double.infinity,
                  width: double.infinity,
                ),
                Container(
                  width: double.infinity,
                  color: AppColors.gray90.withOpacity(0.7),
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "${events[index].title ?? ''} ${cubit.formatDateEvent(events[index].dateTime ?? DateTime.now(), context.read<LocaleCubit>().lang)}",
                    style: textTheme.titleSmall?.copyWith(color: AppColors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      scrollDirection: Axis.vertical,

    );
  }
}
