import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/services/cache_helper.dart';
import '../states/onboarding_states.dart';

class OnboardingCubit extends Cubit<OnboardingStates> {
  OnboardingCubit() : super(OnboardingInitialState());

  static OnboardingCubit get(context) => BlocProvider.of(context);

  final PageController pageController = PageController();

  var currentIndex = 0;

  final List<String> titles = [
    'onboarding_title_1',
    'onboarding_title_2',
    'onboarding_title_3',
    'onboarding_title_4',
    'onboarding_title_5',
  ];

  final List<String> descriptions = [
    'onboarding_desc_1',
    'onboarding_desc_2',
    'onboarding_desc_3',
    'onboarding_desc_4',
    'onboarding_desc_5',
  ];

  final List<String> imagesLight = [
    'assets/images/ic_onboarding_light_1.webp',
    'assets/images/ic_onboarding_light_2.webp',
    'assets/images/ic_onboarding_light_3.webp',
    'assets/images/ic_onboarding_light_4.webp',
    'assets/images/ic_onboarding_light_5.webp',
  ];
  final List<String> imagesDark = [
    'assets/images/ic_onboarding_dark_1.webp',
    'assets/images/ic_onboarding_dark_2.webp',
    'assets/images/ic_onboarding_dark_3.webp',
    'assets/images/ic_onboarding_dark_4.webp',
    'assets/images/ic_onboarding_dark_5.webp',
  ];

  void onPageChanged(int index) async{
    await pageController.animateToPage(index,curve: Curves.fastOutSlowIn,duration: Duration(
      milliseconds: 500
    ));
    currentIndex = index;
    switch (currentIndex) {
      case 4:
        emit(OnboardingIsLastPage());
      default:
        emit(OnboardingOnChangePageState());
    }
  }

  void onSkip() {
    CacheHelper.saveData(key: 'isOpened', value: true);
    emit(OnboardingOnNavigatePage());
  }

  void onChangePage() async {
    currentIndex = (pageController.page?.toInt() ?? -1);
    if (state is OnboardingIsLastPage) {
      onSkip();
    } else {
      switch (currentIndex) {
        case 4:
          emit(OnboardingIsLastPage());
        default:
          emit(OnboardingOnChangePageState());
      }
      await pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn);
    }
  }
}
