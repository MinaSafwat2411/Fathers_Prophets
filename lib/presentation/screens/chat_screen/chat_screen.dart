import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../data/models/classes/class_user_model.dart';
import '../../cubit/chat/cubit/chat_cubit.dart';
import '../../cubit/chat/states/chat_states.dart';
import '../../cubit/layout/cubit/layout_cubit.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import '../../routes.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context);
    var cubit = ChatCubit.get(context);
    var layoutCubit = LayoutCubit.get(context);
    return BlocConsumer<ChatCubit, ChatStates>(
      builder: (context, state) =>
          ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(8),
            children: [
              if(layoutCubit.userData.isAdmin??false)GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoutes.chatBot.name);
                },
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset(
                          context
                              .read<LocaleCubit>()
                              .isDark
                              ? "assets/images/logo_dark.png"
                              : "assets/images/logo_light.png",
                          width: 60,
                          height: 60,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(width: 8,),
                        Text(
                          localize.translate('chatbot'),
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleLarge,
                        ),
                      ],),
                  ),
                ),
              ),
              SizedBox(height: 16,),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,

                  itemBuilder: (context, index) {
                    final servant = cubit.servants[index];
                    final roomId = cubit.generateRoomId(cubit.userData.uid ?? "", servant.uid ?? "");

                    final lastChat = cubit.chats.firstWhereOrNull(
                          (chat) => cubit.generateRoomId(chat.senderUid,cubit.userData.uid??"") == roomId,
                    );

                    final showUnreadDot = lastChat != null &&
                        !lastChat.isRead &&
                        lastChat.senderUid != cubit.userData.uid;

                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(
                          AppRoutes.chat.name,
                          extra: ClassUserModel(
                            name: servant.name,
                            uid: servant.uid,
                            isTeacher: true,
                          ),
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Image.asset(
                                    context.read<LocaleCubit>().isDark
                                        ? "assets/images/logo_dark.png"
                                        : "assets/images/logo_light.png",
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.fill,
                                  ),
                                  if (showUnreadDot)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 12,
                                        width: 12,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(width: 8),
                              Text(
                                servant.name ?? "",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>SizedBox(height: 16,), itemCount: cubit.servants.length)
            ],
          ),
      listener: (context, state) {

      },
    );
  }
}
