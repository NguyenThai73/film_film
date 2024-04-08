import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../provider/message.model.dart';
import 'message.file.dart';
import 'message.image.dart';
import 'message.mess.dart';

class InfoMessage extends StatelessWidget {
  final MessageModel message;
  final bool isAnother;
  const InfoMessage(this.message, {super.key, this.isAnother = false});

  @override
  Widget build(BuildContext context) {
    if (message.type == null) return const SizedBox.shrink();
    switch (message.type!) {
      case "text":
        return isAnother
            ? DecorationAnotherNormal(
                time: message.createTime ?? "",
                name: message.createUserName ?? "",
                child: MessageMess(message, isAnother))
            : DecorationOwnNormal(
                time: message.createTime ?? "",
                child: MessageMess(message, isAnother),
              );
      case "gif":
      case "image":
        return isAnother
            ? DecorationMedia(
                child: MessageImage(message: message, isAnother: isAnother))
            : DecorationMedia(
                child: MessageImage(message: message, isAnother: isAnother),
              );
      case "file":
        return isAnother
            ? DecorationMedia(
                child: MessageFile(message: message, isAnother: isAnother))
            : DecorationMedia(
                child: MessageFile(message: message, isAnother: isAnother),
              );
      case "sendgift":
        return SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(message.message ?? "", style: const TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.w700),),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}

class DecorationAnotherNormal extends StatelessWidget {
  final Widget child;
  final String time;
  final String name;

  const DecorationAnotherNormal(
      {super.key, required this.child, required this.time, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 15),
            Text(
              name,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: CustomPaint(
                painter: PainterAnotherMessageTail(),
                child: const SizedBox(
                  width: 8,
                  height: 10,
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints(minWidth: 50, maxWidth: 200),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.only(
                  left: 20, top: 10, bottom: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(child: child),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    convertDatetime(time),
                    style: const TextStyle(color: Colors.black, fontSize: 11),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DecorationOwnNormal extends StatelessWidget {
  final Widget child;
  final String time;
  const DecorationOwnNormal(
      {super.key, required this.child, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(minWidth: 50, maxWidth: 200),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 241, 246),
              borderRadius: BorderRadius.circular(16)),
          padding:
              const EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(child: child),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                convertDatetime(time),
                style: const TextStyle(color: Colors.black, fontSize: 11),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: CustomPaint(
            painter: PainterOwnMessageTail(),
            child: const SizedBox(
              width: 8,
              height: 10,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}

class DecorationMedia extends StatelessWidget {
  final Widget child;

  const DecorationMedia({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: ClipRRect(borderRadius: BorderRadius.circular(8), child: child),
      ),
    );
  }
}

class PainterOwnMessageTail extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = const Color.fromARGB(255, 255, 227, 236);
    path = Path();
    path.moveTo(-size.width * 0.08, size.height * 0.37);
    path.cubicTo(-size.width * 0.08, size.height * 0.37, size.width * 0.6,
        size.height / 2, size.width, 0);
    path.cubicTo(size.width, 0, size.width * 0.63, size.height * 1.18, 0,
        size.height * 0.98);
    path.cubicTo(0, size.height * 0.98, -size.width * 0.08, size.height * 0.37,
        -size.width * 0.08, size.height * 0.37);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class PainterAnotherMessageTail extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = const Color(0xffffffff);
    path = Path();
    path.moveTo(size.width * 1.02, size.height * 0.37);
    path.cubicTo(size.width * 1.02, size.height * 0.37, size.width * 0.4,
        size.height / 2, 0, 0);
    path.cubicTo(0, 0, size.width * 0.38, size.height * 1.18, size.width,
        size.height * 0.98);
    path.cubicTo(size.width, size.height * 0.98, size.width * 1.02,
        size.height * 0.37, size.width * 0.92, size.height * 0.37);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

String convertDatetime(String inputDatetimeStr) {
  DateTime currentDatetime = DateTime.now();
  DateTime inputDatetime =
      DateFormat("yyyy/MM/dd HH:mm:ss").parse(inputDatetimeStr).toLocal();

  if (inputDatetime.year == currentDatetime.year &&
      inputDatetime.month == currentDatetime.month &&
      inputDatetime.day == currentDatetime.day) {
    return DateFormat("HH:mm").format(inputDatetime);
  } else {
    return DateFormat("HH:mm dd-MM-yyyy").format(inputDatetime);
  }
}
