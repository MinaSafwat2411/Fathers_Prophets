import 'package:fathers_prophets/core/utils/app_colors.dart';
import 'package:fathers_prophets/core/widgets/custom_big_textfield.dart';
import 'package:fathers_prophets/data/models/classes/class_user_model.dart';
import 'package:fathers_prophets/presentation/cubit/chat/cubit/chat_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/chat/states/chat_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../cubit/local/cubit/local_cubit.dart';

class ChatUserScreen extends StatelessWidget {
  const ChatUserScreen({super.key, required this.receiverUserData});
  final ClassUserModel receiverUserData;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>()..listenToRoom(receiverUserData.uid??"")..getFCMToken(receiverUserData.uid??"");
    final localize = AppLocalizations.of(context);
    final isDark = context.read<LocaleCubit>().isDark;
    final textTheme = Theme.of(context).textTheme;
    final iconTheme = Theme.of(context).iconTheme;

    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(receiverUserData.name ?? "", style: textTheme.titleLarge),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              cubit.fcmToken='';
              context.pop();
            },
          ),
          actions: [
            if(cubit.userData.isTeacher??false)IconButton(
              icon: const Icon(Icons.cleaning_services_outlined),
              onPressed: () => cubit.clearChat(receiverUserData.uid??"",cubit.userData.uid??""),
            ),
          ],
        ),
        body: cubit.chatsRoom.isNotEmpty
            ? ListView.separated(
          padding: const EdgeInsets.only(bottom: 100),
          itemCount: cubit.chatsRoom.length,
          separatorBuilder: (_, __) => const SizedBox(height: 4),
          itemBuilder: (context, index) {
            final message = cubit.chatsRoom[index];
            final isMe = message.senderUid == cubit.userData.uid;

            return Align(
              alignment:
              isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(12),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75,
                ),
                decoration: BoxDecoration(
                  color: isMe ? AppColors.riverBed : AppColors.gray,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: Radius.circular(isMe ? 16 : 0),
                    bottomRight: Radius.circular(isMe ? 0 : 16),
                  ),
                ),
                child: Text(
                  message.text,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.white,
                  ),
                ),
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
              boxShadow: [
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
                      cubit.sendMessage(cubit.userData.uid??"",receiverUserData.uid??"", cubit.textController.text);
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

