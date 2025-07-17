import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../cubit/layout/cubit/layout_cubit.dart';
import '../../cubit/layout/states/layout_states.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import 'event_search.dart';
import 'home_screen_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = LayoutCubit.get(context);
    var localize = AppLocalizations.of(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      builder:
          (context, state) => ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SearchBar(
                  focusNode: cubit.searchFocusNode,
                  hintText: localize.translate('search'),
                  leading:
                      state is OnSearchEventOpenState ||
                              state is OnSearchEventState
                          ? GestureDetector(
                            onTap: () => cubit.onSearchEventCloseClicked(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Icon(
                                Icons.close,
                                color:
                                    context.read<LocaleCubit>().isDark
                                        ? AppColors.mirage
                                        : AppColors.white,
                              ),
                            ),
                          )
                          : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.search,
                              color:
                                  context.read<LocaleCubit>().isDark
                                      ? AppColors.mirage
                                      : AppColors.white,
                            ),
                          ),
                  padding: WidgetStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(8),
                  ),
                  controller: cubit.searchController,
                  elevation: WidgetStateProperty.all<double>(2),
                  textStyle: WidgetStatePropertyAll(
                    TextStyle(
                      color:
                          context.read<LocaleCubit>().isDark
                              ? AppColors.mirage
                              : AppColors.white,
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    context.read<LocaleCubit>().isDark
                        ? AppColors.white
                        : AppColors.mirage,
                  ),
                  hintStyle: WidgetStatePropertyAll(
                    TextStyle(
                      color:
                          context.read<LocaleCubit>().isDark
                              ? AppColors.mirage
                              : AppColors.white,
                    ),
                  ),
                  onTap: () => cubit.onSearchEventClicked(),
                  onChanged: (value) => cubit.onSearchEvent(value),
                ),
              ),
              if (state is OnSearchEventOpenState ||
                  state is OnSearchEventState)
                EventSearch(events: cubit.filteredEvents)
              else
                HomeScreenItem(),
            ],
          ),
      listener: (context, state) {},
    );
  }
}
