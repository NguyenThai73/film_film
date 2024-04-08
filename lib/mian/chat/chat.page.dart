// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../constants/appbar.dart';
import '../../constants/button.not.click.multi.dart';
import '../../constants/component/error/error.cubit.dart';
import '../../constants/component/error/error.model.dart';
import '../../constants/component/error/error.widget.dart';
import '../../constants/list.load.state.dart';
import '../../repository/authentication.repository.dart';
import 'chat.cubit.dart';
import 'component/another.message.dart';
import 'component/own.message.dart';
import 'list.chat.cubit.dart';
import 'provider/message.model.dart';

List<String> listGif = [
  "d1.gif",
  "d2.gif",
  "d3.gif",
  "d4.gif",
  "d5.gif",
  "d6.gif",
  "d7.gif",
  "d8.gif",
  "d9.gif",
];

List<String> listAnimation = [
  "2.gif",
  "giphy.gif",
];
List<String> listAnimationAvar = [
  "fier.png",
  "fireword.png",
];

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonNotClickMulti(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: AppbarCustom(
        titilePage: "Chat Page",
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: Container(
                      color: Color.fromARGB(255, 214, 237, 255),
                    )),
                    // Positioned.fill(child: GiftReceiveView()),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: BlocBuilder<ListChatCubit,
                                ListLoadState<MessageModel>>(
                            buildWhen: (previous, current) {
                          return previous.status != current.status ||
                              previous.list.length != current.list.length;
                        }, builder: (context, state) {
                          var listMess = state.list;
                          return (listMess.isNotEmpty)
                              ? ListView.separated(
                                  reverse: true,
                                  addAutomaticKeepAlives: true,
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 10),
                                  itemBuilder: (context, index) {
                                    var message = listMess[index];
                                    if (message.type == "sendgift") {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            message.message ?? "",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      );
                                    }
                                    if (message.createUserId ==
                                        context
                                            .read<AuthenticationRepository>()
                                            .currentUser
                                            ?.id) {
                                      return OwnMessage(
                                        bloc: context.read<ListChatCubit>(),
                                        index,
                                        message,
                                        isShowTime: true,
                                        key: ValueKey('own${message.id}'),
                                      );
                                    } else {
                                      var isShowAvar = true;
                                      return AnotherMessage(
                                        message,
                                        isShowAvar: isShowAvar,
                                        isShowTime: true,
                                        key: ValueKey('another${message.id}'),
                                      );
                                    }
                                  },
                                  itemCount: listMess.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 25,
                                    );
                                  },
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: 150,
                                        child: Image.asset(
                                            "assets/no-message1.png", fit: BoxFit.cover,)),
                                  ],
                                );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 5),
                  InkWell(
                      onTap: () async {
                        context.read<ChatCubit>().chatFocus.unfocus();
                        var response = await showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context1) {
                            return Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 158, 218, 255),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                                padding: const EdgeInsets.only(
                                    top: 25, left: 20, right: 20, bottom: 25),
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 9 / 10,
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 10,
                                  ),
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: listGif.length,
                                  itemBuilder: (context, index) {
                                    return ButtonNotClickMulti(
                                      onTap: () async {
                                        context.pop(listGif[index]);
                                      },
                                      child: Image.asset(
                                        "assets/gif/${listGif[index]}",
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                ));
                          },
                        );
                        if (response != null && response is String) {
                          context.read<ChatCubit>().sendImage(MessageModel(
                                type: "gif",
                                linkFile: response,
                                fileName: response,
                                createUserId: context
                                    .read<AuthenticationRepository>()
                                    .currentUser
                                    ?.id,
                                createUserName: context
                                    .read<AuthenticationRepository>()
                                    .currentUser
                                    ?.name,
                                createUserImage: context
                                    .read<AuthenticationRepository>()
                                    .currentUser
                                    ?.image,
                              ));
                        }
                      },
                      child: Icon(
                        Icons.gif,
                        size: 30,
                        color: const Color.fromARGB(255, 21, 123, 207),
                      )),
                  SizedBox(width: 5),
                  InkWell(
                      onTap: () async {
                        context.read<ChatCubit>().chatFocus.unfocus();
                        var fileName =
                            await context.read<ChatCubit>().handleUploadImage();
                        if (fileName != null) {
                          context.read<ChatCubit>().sendImage(MessageModel(
                                type: "image",
                                linkFile: fileName,
                                fileName: fileName,
                                createUserId: context
                                    .read<AuthenticationRepository>()
                                    .currentUser
                                    ?.id,
                                createUserName: context
                                    .read<AuthenticationRepository>()
                                    .currentUser
                                    ?.name,
                                createUserImage: context
                                    .read<AuthenticationRepository>()
                                    .currentUser
                                    ?.image,
                              ));
                        }
                      },
                      child: Icon(
                        Icons.photo_library,
                        size: 30,
                        color: const Color.fromARGB(255, 21, 123, 207),
                      )),
                  SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey, width: 2)),
                      height: 50,
                      child: TextFormField(
                        onChanged: (value) {},
                        enabled: true,
                        controller: context.read<ChatCubit>().controllerChat,
                        style: TextStyle(),
                        onTap: () {},
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: "Aa",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFBBBBBB)),
                          suffixIconConstraints: const BoxConstraints.expand(
                              width: 30, height: 20),
                          contentPadding: const EdgeInsets.only(
                              left: 10, right: 8, top: 8, bottom: 8),
                          isCollapsed: true,
                          border: InputBorder.none,
                        ),
                        focusNode: context.read<ChatCubit>().chatFocus,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 81, 168, 238),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: InkWell(
                      onTap: () async {
                        var check = await context
                            .read<ChatCubit>()
                            .sendText(MessageModel(
                              type: "text",
                              linkFile: "",
                              fileName: "",
                              createUserId: context
                                  .read<AuthenticationRepository>()
                                  .currentUser
                                  ?.id,
                              createUserName: context
                                  .read<AuthenticationRepository>()
                                  .currentUser
                                  ?.name,
                              createUserImage: context
                                  .read<AuthenticationRepository>()
                                  .currentUser
                                  ?.image,
                            ));
                        if (check == false) {
                          context.read<ErrorCubit>().showDialog(
                              widgetShow: ErrorWidgetApp(
                                  errorModel: ErrorModel(
                                      title: "Contains prohibited language.")));
                        }
                      },
                      child: Center(
                        child: Icon(Icons.send, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}

// class ExampleMenu extends StatelessWidget {
//   final MessageModel message;
//   const ExampleMenu({
//     super.key,
//     required this.builder,
//     required this.message,
//   });

//   final PullDownMenuButtonBuilder builder;

//   @override
//   Widget build(BuildContext context) => PullDownButton(
//         itemBuilder: (context) => [
//           PullDownMenuItem(
//             onTap: () {
//               context.read<ListChatCubit>().delete(message);
//             },
//             title: 'Delete',
//             isDestructive: true,
//             icon: Icons.delete,
//           ),
//         ],
//         animationBuilder: null,
//         position: PullDownMenuPosition.automatic,
//         buttonBuilder: builder,
//       );
// }
