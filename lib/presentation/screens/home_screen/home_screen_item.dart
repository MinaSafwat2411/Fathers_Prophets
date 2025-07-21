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
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (cubit.comingEvents.isNotEmpty)Text(
          localize.translate('coming_events'),
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        if (cubit.comingEvents.isNotEmpty)SizedBox(
          height:MediaQuery.of(context).size.height*0.13,
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder:
                (context, index) => Column(
              children: [
                GestureDetector(
                  onTap: () async {
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color:
                      context.read<LocaleCubit>().isDark
                          ? AppColors.riverBed
                          : AppColors.slateGray,
                      margin: EdgeInsets.zero,
                      child: cubit.comingEvents[index].image != ''
                          ? CachedNetworkImage(
                        width: MediaQuery.of(context).size.width*0.18,
                        height: MediaQuery.of(context).size.height*0.08,
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
                            ? 'assets/images/ic_${cubit.comingEvents[index].nameEn?.toLowerCase()}_dark.png'
                            : 'assets/images/ic_${cubit.comingEvents[index].nameEn?.toLowerCase()}_light.png',
                        width: MediaQuery.of(context).size.width*0.18,
                        height: MediaQuery.of(context).size.height*0.08,
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
