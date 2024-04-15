// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import '../../../constants/avar.dart';
import '../provider/message.model.dart';
import 'info.message.dart';

class OwnMessage extends StatelessWidget {
  final bloc;
  final int index;
  final MessageModel message;
  final bool isShowTime;
  const OwnMessage(this.index, this.message, {super.key, required this.isShowTime, required this.bloc});

  @override
  Widget build(BuildContext contextCurrent) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: SizedBox.shrink()),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: InfoMessage(message),
        ),
        const ClipOval(child: SizedBox(width: 46, height: 46, child: AvartarApp())),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
