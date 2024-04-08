import 'package:film_film/constants/dialog.show.image.dart';
import 'package:flutter/material.dart';

import '../provider/message.model.dart';
import 'info.message.dart';

class MessageImage extends StatelessWidget {
  final MessageModel message;
  final bool isAnother;
  const MessageImage(
      {super.key, required this.message, required this.isAnother});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 165),
      child: InkWell(
        onTap: () {
          if (message.type == "image") {
            context.showDialogImage(message.linkFile ?? "");
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: isAnother
                  ? Colors.white
                  : const Color.fromARGB(255, 255, 241, 246),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment:
                isAnother ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              isAnother
                  ? Text(
                      "${message.createUserName}",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 5),
              (message.type == "image")
                  ? Image.network(
                      message.linkFile ?? "",
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      "assets/gif/${message.fileName}",
                      fit: BoxFit.contain,
                    ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    convertDatetime(message.createTime ?? ""),
                    style: const TextStyle(color: Colors.black, fontSize: 11),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
