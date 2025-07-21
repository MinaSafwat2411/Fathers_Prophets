import 'package:fathers_prophets/presentation/cubit/layout/states/layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../cubit/layout/cubit/layout_cubit.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import '../../routes.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    var cubit = LayoutCubit.get(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(localize.translate('categories'),style: textTheme.titleLarge,),
            centerTitle: true,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: Icon(Icons.arrow_back_ios_new_outlined),
            ),
          ),
          body: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            shrinkWrap: true,
            itemCount: cubit.categories.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () async {
                 await context.pushNamed(AppRoutes.eventDetails.name, extra: {
                'title':cubit.categories[index],
                'items':cubit.categoriesEvents[index]
              });
                 cubit.getAllData();
              },
              child: SizedBox(
                height: 150,
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
            ),
            scrollDirection: Axis.vertical,
          ),
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            onPressed: () async {
              var event = await context.pushNamed(AppRoutes.addEvent.name);
              if (!context.mounted) return;
              if (event != null) {
                cubit.getAllData();
              }
            },
            child: const Icon(Icons.edit),
          ),
        ),
        listener: (context, state) {

        },
    );
  }
}
