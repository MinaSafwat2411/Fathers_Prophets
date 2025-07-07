import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/event_shimmer_item.dart';
import '../../cubit/layout/cubit/layout_cubit.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import '../../routes.dart';
import 'home_screen_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = LayoutCubit.get(context);
    var localize = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      children: [
        if(cubit.comingEvents.isNotEmpty)Text(localize.translate('coming_events'),style: Theme.of(context).textTheme.titleLarge,textAlign: TextAlign.center,),
        if(cubit.comingEvents.isNotEmpty)SizedBox(
          height: 150,
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Column(
              children: [
                MaterialButton(
                  height: 100,
                onPressed: () async{
                  var result = await context.pushNamed(AppRoutes.addEventAttendance.name,
                      extra: {
                        'item': cubit.comingEvents[index],
                        'title': cubit.comingEvents[index].nameEn,
                      });
                  if(result != null){
                    cubit.getAllData();
                  }
                },
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  shape: CircleBorder(),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                      imageUrl: cubit.comingEvents[index].image ?? '',
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
                ),
                ),
                Text(cubit.comingEvents[index].nameAr ?? "",textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyMedium,),
              ],
            ), separatorBuilder: (context, index) => SizedBox(), itemCount: cubit.comingEvents.length),
        ),
        HomeScreenItem(events: cubit.footballEvents,title: 'football',),
        HomeScreenItem(events: cubit.bibleEvents,title: 'bible',),
        HomeScreenItem(events: cubit.chessEvents,title: 'chess',),
        HomeScreenItem(events: cubit.choirEvents,title: 'choir',),
        HomeScreenItem(events: cubit.copticEvents,title: 'coptic',),
        HomeScreenItem(events: cubit.doctrineEvents,title: 'doctrine',),
        HomeScreenItem(events: cubit.melodiesEvents,title: 'melodies',),
        HomeScreenItem(events: cubit.pingPongEvents,title: 'pingPong',),
        HomeScreenItem(events: cubit.volleyballEvents,title: 'volleyball',),
        HomeScreenItem(events: cubit.ritualEvents,title: 'ritual',),
        HomeScreenItem(events: cubit.prayEvents,title: 'pray',),
        HomeScreenItem(events: cubit.praiseEvents,title: 'praise',),
      ],
    );
  }
}
