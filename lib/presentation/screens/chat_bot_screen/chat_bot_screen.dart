import 'package:fathers_prophets/core/utils/app_colors.dart';
import 'package:fathers_prophets/core/widgets/custom_big_textfield.dart';
import 'package:fathers_prophets/presentation/cubit/chatbot/cubit/chatbot_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/localization/app_localizations.dart';
import '../../cubit/chatbot/states/chatbot_states.dart';
import '../../cubit/local/cubit/local_cubit.dart';

class ChatBotScreen extends StatelessWidget {
  const ChatBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<ChatbotCubit>(context);
    final localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    return BlocConsumer<ChatbotCubit, ChatbotStates>(
        builder: (context, state) => Scaffold(
            appBar: AppBar(
                title: Text(localize.translate('chatbot'),style: textTheme.titleLarge,),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  onPressed: () {
                    context.pop();
                  },
                ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.cleaning_services_outlined),
                  onPressed: () {
                    cubit.onClearChat();
                  },
                )
              ],
            ),
            body: cubit.messages.isNotEmpty ? ListView.separated(
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(top: 8,left: 8,right: 8,bottom: index == cubit.messages.length-1 ? 100 : 8),
                  child: Column(
                    crossAxisAlignment: cubit.messages[index].sender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: cubit.messages[index].sender ? AppColors.gray:AppColors.riverBed,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(cubit.messages[index].message,style: textTheme.bodyLarge?.copyWith(
                            color: AppColors.white
                          )),
                        ),
                      ),
                      SizedBox(height: 8,),
                      if(state is OnLoadingMassage && index == cubit.messages.length-1)Container(
                        alignment: context.read<LocaleCubit>().lang=='ar' ? Alignment.centerRight : Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: AppColors.riverBed,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
                          child: LoadingAnimationWidget.waveDots(
                              color: AppColors.mirage, size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(height: 0,),
                itemCount: cubit.messages.length
            ):Center(
              child: Image.asset(
                context.read<LocaleCubit>().isDark ? "assets/images/logo_dark.png" : "assets/images/logo_light.png",
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              ),
            ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: context.read<LocaleCubit>().isDark ? AppColors.mirage:AppColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(24))
              ),
              child: CustomBigTextField(
                  border: 24,
                  controller: cubit.textController,
                  isDark: context.read<LocaleCubit>().isDark,
                  observe: false,
                suffix: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    cubit.onSendMessage();
                  },
                ),
                label: localize.translate('send'),
              ),
            ),
          ),
        ),
        listener: (context, state) {

        },
    );
  }
}
