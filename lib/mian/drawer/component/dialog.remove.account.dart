// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogRemoveAccountWidget extends StatelessWidget {
  const DialogRemoveAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      // children: [
      //   Container(
      //     padding: const EdgeInsets.all(10),
      //     decoration: const BoxDecoration(
      //       gradient: LinearGradient(
      //           begin: Alignment.centerLeft,
      //           end: Alignment.centerRight,
      //           colors: <Color>[Color(0xff9190ed), Color(0xfff8c3d3)]),
      //     ),
      //     child: Center(
      //         child: Text(
      //       MyString.titleDeleteAccount,
      //       style: MyTextStyle.heading5.copyWith(
      //           fontSize: 16,
      //           color: MyColor.neutralBackground,
      //           fontWeight: FontWeight.w700),
      //     )),
      //   ),
      //   const SizedBox(height: 20),
      //   ClipOval(
      //       child: SizedBox(
      //           width: 100,
      //           height: 100,
      //           child: Image.asset(MyImageAsset.avatarBack))),
      //   CustomPaint(
      //     size: MediaQuery.of(context).size,
      //     painter: Painter(),
      //     child: const SizedBox(
      //       width: 10,
      //       height: 10,
      //     ),
      //   ),
      //   Container(
      //     height: 34,
      //     width: MediaQuery.of(context).size.width * 0.65,
      //     decoration: BoxDecoration(
      //         color: const Color(0xFFf7e8fa),
      //         borderRadius: BorderRadius.circular(17)),
      //     child: Center(
      //       child: FittedBox(
      //           child: Text(
      //         MyString.anserDeleteAccount,
      //         style: MyTextStyle.body1.copyWith(
      //             fontSize: 12,
      //             fontWeight: FontWeight.w400,
      //             color: Colors.black),
      //       )),
      //     ),
      //   ),
      //   Container(
      //     margin:
      //         const EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 10),
      //     child: Text(
      //       MyString.contentDeleteAccount,
      //       textAlign: TextAlign.center,
      //       style: MyTextStyle.body1.copyWith(
      //           fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black),
      //     ),
      //   ),
      //   const Text(
      //     MyString.reAnserDeleteAccount,
      //     style: TextStyle(
      //         fontSize: 13,
      //         fontWeight: FontWeight.w900,
      //         color: Color(0xFFEA3800)),
      //   ),
      //   Container(
      //     margin: const EdgeInsets.only(top: 25),
      //     padding: const EdgeInsets.all(10),
      //     width: MediaQuery.of(context).size.width * 0.65,
      //     decoration: BoxDecoration(
      //         // color: MyColor.colorStart,
      //         gradient: const LinearGradient(
      //           colors: [
      //             Color(0xffa139ef),
      //             Color(0xffdb73b9)
      //           ], // Mảng màu để tạo dốc
      //         ),
      //         borderRadius: BorderRadius.circular(20)),
      //     child: InkWell(
      //       onTap: () {
      //         Navigator.pop(context);
      //       },
      //       child: Center(
      //         child: Text(
      //           MyString.btnCancelLogoutTitle,
      //           style: MyTextStyle.heading5.copyWith(
      //               fontSize: 16,
      //               color: MyColor.neutralBackground,
      //               fontWeight: FontWeight.w500),
      //         ),
      //       ),
      //     ),
      //   ),
      //   Container(
      //     margin: const EdgeInsets.only(top: 5, bottom: 15),
      //     padding: const EdgeInsets.all(10),
      //     width: MediaQuery.of(context).size.width * 0.65,
      //     decoration: BoxDecoration(
      //         color: MyColor.neutralBackground,
      //         border: Border.all(
      //           width: 1,
      //           color: const Color(0xffa139ef),
      //         ),
      //         borderRadius: BorderRadius.circular(20)),
      //     child: InkWell(
      //       onTap: () async {
      //         try {
      //           var token = await MySharedPreferences.getToken();
      //           var check = await context
      //               .read<AuthenticationRepository>()
      //               .removeAccount(token);
      //           if (check) {
      //             context.read<MainCubit>().selectBottomBar(
      //                 conversationModel: null,
      //                 page: 0,
      //                 pageNumberGoToConversation: null);
      //             FireMessage.unsubscribeFromTopic();
      //             await context.read<AuthenticationRepository>().logOut();
      //             await context.read<NotifyUnseenCubit>().resetNumberUnseen();
      //             await context.read<MessUnseenCubit>().resetNumberUnseen();
      //             await MySharedPreferences.clearToken();
      //             context.popUntilPath('/');
      //           }
      //         } on Exception catch (e) {
      //           context.read<ErrorCubit>().showDialog(
      //               widgetShow: ErrorWidgetApp(
      //                   errorModel:
      //                       ErrorModel(title: e.getMessageError, content: "")));
      //         }
      //       },
      //       child: Center(
      //         child: Text(
      //           MyString.btnAgreeDeleteAccount,
      //           style: MyTextStyle.heading5.copyWith(
      //               fontSize: 16,
      //               color: const Color(0xff333333),
      //               fontWeight: FontWeight.w500),
      //         ),
      //       ),
      //     ),
      //   ),
      // ],
    );
  }
}

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();
    paint.color = const Color(0xFFF7E8FA);
    path = Path();
    path.moveTo(size.width * 8, 15);
    path.lineTo(size.width * 8, 15);
    path.lineTo(size.width * 6.7, 15);
    path.lineTo(size.width * 6, -5);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

extension GetMessage on Exception {
  String get getMessageError => toString().substring(10);
}
