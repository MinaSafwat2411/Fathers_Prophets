import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../cubit/layout/cubit/layout_cubit.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import '../../routes.dart';

class CategoriesItem extends StatelessWidget {
  const CategoriesItem({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = LayoutCubit.get(context);
    var localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    var iconTheme = Theme.of(context).iconTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localize.translate('categories'),
                style: textTheme.titleLarge,
              ),
              GestureDetector(
                onTap: () async{
                  await context.pushNamed(AppRoutes.categories.name);
                  cubit.getAllData();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      localize.translate('view_all'),
                      style: textTheme.bodyLarge,
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: iconTheme.color,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8,),
        SizedBox(
          height: 160,
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => context.pushNamed(AppRoutes.eventDetails.name, extra: {
                'title':cubit.categories[index],
                'items':cubit.categoriesEvents[index]
              }),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: Card(
                      margin: EdgeInsets.zero,
                      color:
                      context.read<LocaleCubit>().isDark
                          ? AppColors.riverBed
                          : AppColors.slateGray,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image(
                          image: AssetImage(
                            context.read<LocaleCubit>().isDark
                                ? "assets/images/ic_${cubit.categories[index].toLowerCase()}_dark.png"
                                : "assets/images/ic_${cubit.categories[index].toLowerCase()}_light.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    width: 70,
                    child: Text(
                      localize.translate(cubit.categories[index]),
                      style: textTheme.bodySmall?.copyWith(fontSize: 10),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis, // Prevents overflow
                      maxLines: 2, // Limit lines
                    ),
                  ),
                ],
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(width: 8),
          ),
        ),
      ],
    );
  }
}
