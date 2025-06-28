import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      children: [
        CarouselSlider.builder(
          itemCount: cubit.comingEvents.length,
          itemBuilder: (context, index, realIndex) {
            final item = cubit.comingEvents[index];
            return GestureDetector(
              onTap: () {
                context.pushNamed(AppRoutes.addEventAttendance.name,
                    extra: {
                      'item': item,
                      'title': item.nameEn,
                    });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.fill,
                  imageUrl: item.image ?? '',
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
            );
          },
          options: CarouselOptions(
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            height: 200,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
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
      ],
    );
  }
}
