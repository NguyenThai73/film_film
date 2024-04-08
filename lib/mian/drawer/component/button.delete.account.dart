// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'dialog.remove.account.dart';

class ButtonDeleteAccountWdget extends StatelessWidget {
  const ButtonDeleteAccountWdget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return const DialogRemoveAccountWidget();
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(color: Color.fromARGB(255, 255, 108, 97)),
              child: Center(
                  child: Text(
                "Delete account",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              )),
            ),
          ),
        ),
      ],
    );
  }
}
