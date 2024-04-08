// ignore_for_file: unused_element

import 'package:film_film/constants/share.preference.dart';
import 'package:film_film/main.router.dart';
import 'package:film_film/repository/authentication.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonLogoutWdget extends StatefulWidget {
  const ButtonLogoutWdget({super.key});

  @override
  State<ButtonLogoutWdget> createState() => _ButtonLogoutWdgetState();
}

class _ButtonLogoutWdgetState extends State<ButtonLogoutWdget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              await context.read<AuthenticationRepository>().logOut();
              MySharedPreferences.clear();
              context.popUntilPath('/');
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              // height: 100,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 21, 142, 255),
              ),
              child: Center(
                  child: Text(
                "Log out",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 255, 255, 255)),
              )),
            ),
          ),
        ),
      ],
    );
  }
}
