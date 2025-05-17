import 'package:fathers_prophets/presentation/screens/onboarding_screen/widgets/onboarding_bottom_button.dart';
import 'package:fathers_prophets/presentation/screens/onboarding_screen/widgets/onboarding_item.dart';
import 'package:fathers_prophets/presentation/screens/onboarding_screen/widgets/onboarding_top_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/app_localizations.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import '../../cubit/onboarding/cubit/onboarding_cubit.dart';
import '../../cubit/onboarding/states/onboarding_states.dart';
import '../../routes.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context);

    var cubit = OnboardingCubit.get(context);
    return BlocConsumer<OnboardingCubit, OnboardingStates>(
      listener: (context, state) {
        if (state is OnboardingOnNavigatePage) {
          context.goNamed(AppRoutes.login.name);
        }
      },
      listenWhen: (previous, current) => current is OnboardingOnNavigatePage,
      buildWhen:
          (previous, current) =>
              current is OnboardingIsLastPage ||
              current is OnboardingOnChangePageState,
      builder: (context, state) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OnboardingTopButton(
                isDark: context.read<LocaleCubit>().isDark,
                index:cubit.currentIndex
              ),
              Expanded(
                child: PageView(
                  onPageChanged: (value) {
                    cubit.onPageChanged(value);
                  },
                  controller: cubit.pageController,
                  children: List.generate(
                    cubit.imagesLight.length,
                    (index) => OnboardingItem(
                      title: localize.translate(cubit.titles[index]),
                      description: localize.translate(
                        cubit.descriptions[index],
                      ),
                      image: context.read<LocaleCubit>().isDark ? cubit.imagesDark[index] : cubit.imagesLight[index],
                    ),
                  ),
                ),
              ),
              OnboardingBottomButton(
                pageController: cubit.pageController,
                title:
                    state is OnboardingIsLastPage
                        ? localize.translate('get_started')
                        : localize.translate('next'),
                function: () => cubit.onChangePage(),
                isDark: context.read<LocaleCubit>().isDark,
                lang: context.read<LocaleCubit>().lang,
                text: localize.translate('skip'),
                skip: () => cubit.onSkip(),
              ),
            ],
          ),
        );
      },
    );
  }
}
