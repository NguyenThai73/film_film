import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/button.not.click.multi.dart';

class NotiUpdateSuccess extends StatelessWidget {
  const NotiUpdateSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Update Success",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonNotClickMulti(
                  onTap: () {
                    context.pop();
                  },
                  child: Container(
                    width: 150,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 0, 8, 255),
                            Color.fromARGB(255, 0, 187, 255)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text('OK',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16)),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
