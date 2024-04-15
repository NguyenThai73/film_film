// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/avar.with.type.contact.dart';
import '../../../constants/bottom.sheet.dialog.temp.dart';
import '../../../constants/button.not.click.multi.dart';
import '../../../repository/authentication.repository.dart';
import '../chat.cubit.dart';
import '../list.chat.cubit.dart';
import '../provider/message.model.dart';
import 'info.message.dart';

class AnotherMessage extends StatelessWidget {
  final MessageModel message;
  final bool isShowAvar;
  final bool isShowTime;
  const AnotherMessage(this.message,
      {super.key, required this.isShowAvar, required this.isShowTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (isShowAvar && message.type != "sendgift")
            Positioned(
                left: 0,
                top: 10,
                child: SizedBox(
                    width: 46,
                    height: 46,
                    child: AvarNormal(avar: message.createUserImage ?? ''))),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                width: 44,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 10),
                child: InfoMessage(
                  message,
                  isAnother: true,
                ),
              ),
              (message.type != "sendgift")
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 25, left: 10),
                      child: ButtonNotClickMulti(
                        onTap: () async {
                          var response = await showDialog(
                            context: context,
                            builder: (context) => DialogBottomSheetTemp(
                              child: Center(
                                child: Container(
                                  
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 305,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: FittedBox(
                                          child: Text(
                                            "Submit a report if messages from ${message.createUserName} \nvviolate any of the following:\n- Content violating the law.\n- Content not meeting societal standards.\n- Content intended to cause controversy.\n- Content intended to sell or promote\nprohibited products.",
                                            style: const TextStyle(
                                                fontSize: 16, color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        "Note: You are responsible for the content of your report.",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                                255, 255, 119, 109)),
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color.fromARGB(
                                                  255, 255, 105, 94),
                                            ),
                                            child: ButtonNotClickMulti(
                                              onTap: () {
                                                context.pop(true);
                                              },
                                              child: const Center(
                                                child: Text("Report",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                            ),
                                          ),
                                           const SizedBox(width: 5),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.orange),
                                            child: ButtonNotClickMulti(
                                              onTap: () {
                                                context.pop(false);
                                              },
                                              child: const Center(
                                                child: Text("Block",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                            ),
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                          if (response != null &&
                              response is bool &&
                              response == true) {
                            print("message: ${message.toMap()}");
                            await context.read<ChatCubit>().reportMessage(
                                  userReport: context
                                          .read<AuthenticationRepository>()
                                          .currentUser
                                          ?.id ??
                                      "",
                                  messageReport: message.id ?? "",
                                );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor:
                                    Color.fromARGB(194, 45, 45, 45),
                                content: Text(
                                  "Report successful.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }if(response != null &&
                              response is bool &&
                              response == false){
                             context.read<ListChatCubit>().handleBlockUser(
                                  userIdIsBlock: message.createUserId ?? "");
                          }
                        },
                        child: const Icon(
                          Icons.report,
                          color: Color.fromARGB(255, 255, 148, 140),
                        ),
                      ))
                  : const SizedBox.shrink(),
              const Expanded(child: SizedBox.shrink()),
            ],
          ),
        ],
      ),
    );
  }
}
