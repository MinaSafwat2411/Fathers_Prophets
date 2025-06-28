import 'package:fathers_prophets/core/utils/app_colors.dart';
import 'package:fathers_prophets/core/widgets/custom_loading.dart';
import 'package:fathers_prophets/data/services/cache_helper.dart';
import 'package:fathers_prophets/presentation/cubit/local/cubit/local_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../cubit/dashboard/cubit/dashboard_cubit.dart';
import '../../cubit/dashboard/states/dashboard_states.dart';
import '../../routes.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    var cardTheme = Theme.of(context).cardTheme;
    var cubit = DashboardCubit.get(context);
    return BlocConsumer<DashboardCubit, DashboardStates>(
      builder:
          (context, state) => Scaffold(
            appBar: AppBar(
              title: Text(localize.translate("dash_board")),
              leading: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 55,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder:
                          (context, index) => GestureDetector(
                            onTap: () => cubit.onFilter(index),
                            child: Card(
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: AppColors.transparent
                                )
                              ),
                              color:
                                  cubit.selected != index
                                      ? cardTheme.color
                                      : context.read<LocaleCubit>().isDark
                                      ? AppColors.white
                                      : AppColors.mirage,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 15,
                                ),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  cubit.list[index],
                                  style: textTheme.bodyMedium?.copyWith(
                                    color:
                                        cubit.selected != index
                                            ? textTheme.bodyMedium?.color
                                            : context.read<LocaleCubit>().isDark
                                            ? AppColors.black
                                            : AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      separatorBuilder: (context, index) => const SizedBox(),
                      itemCount: cubit.list.length,
                    ),
                  ),
                  state is! OnLoading
                      ? Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                              columns: [
                                DataColumn(
                                  label: Text(localize.translate('name')),
                                ),
                                DataColumn(
                                  label: Text(localize.translate('class')),
                                ),
                                DataColumn(
                                  label: Text(localize.translate('bible')),
                                ),
                                DataColumn(
                                  label: Text(localize.translate('football')),
                                ),
                                DataColumn(
                                  label: Text(localize.translate('ritual')),
                                ),
                                DataColumn(
                                  label: Text(localize.translate('chess')),
                                ),
                                DataColumn(
                                  label: Text(localize.translate('choir')),
                                ),
                                DataColumn(
                                  label: Text(localize.translate('melodies')),
                                ),
                                DataColumn(
                                  label: Text(localize.translate('doctrine')),
                                ),
                                DataColumn(
                                  label: Text(localize.translate('volleyball')),
                                ),
                                DataColumn(
                                  label: Text(localize.translate('pingPong')),
                                ),
                                DataColumn(
                                  label: Text(localize.translate('coptic')),
                                ),
                                DataColumn(
                                  label: Text(localize.translate('quizzes')),
                                ),
                              ],
                              rows:
                                  cubit.membersFiltered.map((user) {
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                            GestureDetector(
                                                onTap: () {
                                                  context.pushNamed(AppRoutes.userDetails.name, extra: {
                                                    'user':user,
                                                    'football':cubit.football,
                                                    'volleyball':cubit.volleyball,
                                                    'pingPong':cubit.pingPong,
                                                    'chess':cubit.chess,
                                                    'melodies':cubit.melodies,
                                                    'choir':cubit.choir,
                                                    'ritual':cubit.ritual,
                                                    'coptic':cubit.coptic,
                                                    'doctrine':cubit.doctrine,
                                                    'bible':cubit.bible,
                                                    'quizzes':cubit.quizzes,
                                                  });
                                                },
                                                child:
                                                Text(user.name ?? ''))),
                                        DataCell(
                                          Text(
                                            CacheHelper.getClasses()
                                                    .firstWhere(
                                                      (element) =>
                                                          element.docId ==
                                                          user.classId,
                                                    )
                                                    .name ??
                                                "",
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            "${user.bible?.length ?? 0} / ${cubit.bible}",
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            "${user.football?.length ?? 0} / ${cubit.football}",
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            "${user.ritual?.length ?? 0} / ${cubit.ritual}",
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            "${user.chess?.length ?? 0} / ${cubit.chess}",
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            "${user.choir?.length ?? 0} / ${cubit.choir}",
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            "${user.melodies?.length ?? 0} / ${cubit.melodies}",
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            "${user.doctrine?.length ?? 0} / ${cubit.doctrine}",
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            "${user.volleyball?.length ?? 0} / ${cubit.volleyball}",
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            "${user.pingPong?.length ?? 0} / ${cubit.pingPong}",
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            "${user.coptic?.length ?? 0} / ${cubit.coptic}",
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            "${user.quizzes?.length ?? 0} / ${cubit.quizzes}",
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                            ),
                          ),
                        ),
                      )
                      : CustomLoading(
                        isDark: context.read<LocaleCubit>().isDark,
                      ),
                ],
              ),
            ),
          ),
      listener: (context, state) {},
      buildWhen:
          (previous, current) =>
              current is OnFilter ||
              current is OnSuccess ||
              current is OnLoading,
    );
  }
}
