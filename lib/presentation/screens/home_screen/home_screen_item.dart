import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/event_shimmer_item.dart';
import '../../cubit/layout/cubit/layout_cubit.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import '../../routes.dart';
import 'categories_item.dart';

class HomeScreenItem extends StatelessWidget {
  const HomeScreenItem({super.key});


  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final localize = AppLocalizations.of(context);
    var cubit = LayoutCubit.get(context);
    return Column(
      children: [
        if (cubit.comingEvents.isNotEmpty)Text(
          localize.translate('coming_events'),
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        if (cubit.comingEvents.isNotEmpty)SizedBox(
          height: 160,
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder:
                (context, index) => Column(
              children: [
                MaterialButton(
                  height: 100,
                  onPressed: () async {
                    var result = await context.pushNamed(
                      AppRoutes.addEventAttendance.name,
                      extra: {
                        'item': cubit.comingEvents[index],
                        'title': cubit.comingEvents[index].nameEn,
                      },
                    );
                    if (result != null) {
                      cubit.getAllData();
                    }
                  },
                  child: Card(
                    color:
                    context.read<LocaleCubit>().isDark
                        ? AppColors.riverBed
                        : AppColors.slateGray,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    shape: CircleBorder(),
                    child: ClipOval(
                      child:
                      cubit.comingEvents[index].image != ''
                          ? CachedNetworkImage(
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                        imageUrl:
                        cubit.comingEvents[index].image ?? '',
                        placeholder:
                            (context, url) => EventShimmerItem(
                          isDark:
                          context
                              .read<LocaleCubit>()
                              .isDark,
                        ),
                        errorWidget:
                            (context, url, error) =>
                            EventShimmerItem(
                              isDark:
                              context
                                  .read<LocaleCubit>()
                                  .isDark,
                            ),
                      )
                          : Image.asset(
                        context.read<LocaleCubit>().isDark
                            ? 'assets/images/logo_dark.png'
                            : 'assets/images/logo_light.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Text(
                  cubit.comingEvents[index].nameAr ?? "",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            separatorBuilder: (context, index) => SizedBox(),
            itemCount: cubit.comingEvents.length,
          ),
        ),
        CategoriesItem()
      ],
    );
  }
}
