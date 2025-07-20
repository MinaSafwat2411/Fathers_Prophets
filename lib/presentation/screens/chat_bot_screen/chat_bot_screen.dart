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
    final cubit = context.read<ChatbotCubit>();
    final localize = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isDark = context.read<LocaleCubit>().isDark;

    return BlocConsumer<ChatbotCubit, ChatbotStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(localize.translate('chatbot'), style: textTheme.titleLarge),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () => context.pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.cleaning_services_outlined),
              onPressed: () => cubit.onClearChat(),
            )
          ],
        ),
        body: cubit.messages.isNotEmpty
            ? ListView.separated(
          padding: const EdgeInsets.only(bottom: 100),
          itemCount: cubit.messages.length,
          separatorBuilder: (_, __) => const SizedBox(height: 4),
          itemBuilder: (context, index) {
            final msg = cubit.messages[index];
            final isMe = msg.sender;

            return Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Column(
                crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: isMe ? AppColors.gray : AppColors.riverBed,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isMe ? 16 : 0),
                        bottomRight: Radius.circular(isMe ? 0 : 16),
                      ),
                    ),
                    child: Text(
                      msg.message,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  if (state is OnLoadingMassage &&
                      index == cubit.messages.length - 1)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
                      child: Align(
                        alignment: isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppColors.riverBed,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: LoadingAnimationWidget.waveDots(
                            color: AppColors.mirage,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        )
            : Center(
          child: Image.asset(
            isDark
                ? "assets/images/logo_dark.png"
                : "assets/images/logo_light.png",
            width: 150,
            height: 150,
            fit: BoxFit.contain,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? AppColors.mirage : AppColors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                ),
              ],

            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomBigTextField(
                    controller: cubit.textController,
                    border: 24,
                    isDark: isDark,
                    observe: false,
                    label: localize.translate('send'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (cubit.textController.text.trim().isNotEmpty) {
                      cubit.onSendMessage();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
