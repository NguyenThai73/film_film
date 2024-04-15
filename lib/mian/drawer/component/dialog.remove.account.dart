// ignore_for_file: use_build_context_synchronously

import 'package:film_film/constants/avar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_user/service_user.dart';

import '../../../constants/component/error/error.cubit.dart';
import '../../../constants/component/error/error.model.dart';
import '../../../constants/component/error/error.widget.dart';
import '../../../constants/component/loading/loading.cubit.dart';
import '../../../constants/share.preference.dart';
import '../../../repository/authentication.repository.dart';

class DialogRemoveAccountWidget extends StatelessWidget {
  const DialogRemoveAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
        const SizedBox(height: 20),
        ClipOval(child: SizedBox(width: 100, height: 100, child: AvartarApp())),
        CustomPaint(
          size: MediaQuery.of(context).size,
          painter: Painter(),
          child: const SizedBox(
            width: 10,
            height: 10,
          ),
        ),
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
        const Text(
          "Your information will be permanently deleted. Are you sure you want to delete?",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color(0xFFEA3800)),
        ),
        Container(
          margin: const EdgeInsets.only(top: 25),
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.65,
          decoration: BoxDecoration(
              // color: MyColor.colorStart,
              gradient: const LinearGradient(
                colors: [Color.fromARGB(255, 239, 57, 57), Color.fromARGB(255, 255, 82, 48)], // Mảng màu để tạo dốc
              ),
              borderRadius: BorderRadius.circular(20)),
          child: InkWell(
            onTap: () async {
              context.read<LoadingCubit>().makeLoading();
              var response =
                  await context.read<AuthenticationRepository>().deteteAccount(context.read<AuthenticationRepository>().currentUser ?? UserModel());
              if (response) {
                MySharedPreferences.clear();
                context.read<LoadingCubit>().makeNoneLoading();
                context.read<AuthenticationRepository>().requestEmptyUser();
              } else {
                context.read<LoadingCubit>().makeNoneLoading();
                context.read<ErrorCubit>().showDialog(widgetShow: ErrorWidgetApp(errorModel: ErrorModel()));
              }
            },
            child: Center(
              child: Text(
                "Delete",
                style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 15),
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.65,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: Color.fromARGB(255, 111, 111, 111),
              ),
              borderRadius: BorderRadius.circular(20)),
          child: InkWell(
            onTap: () async {
              Navigator.pop(context);
            },
            child: Center(
              child: Text(
                "Cancel",
                style: TextStyle(fontSize: 16, color: const Color(0xff333333), fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ],
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
