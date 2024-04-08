import 'package:film_film/main.router.constant.dart';
import 'package:film_film/mian/login/policy.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../login/term.screen.dart';
import '../mian.cubit.dart';
import 'component/button.delete.account.dart';
import 'component/button.logout.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        leading: InkWell(
            onTap: () {
              context.read<MainCubit>().closeEndDrawer();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: Colors.white,
            )),
        centerTitle: true,
        title: const Text(
          "Setting",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: () {
              context.read<MainCubit>().closeEndDrawer();
            },
            child: Icon(
              Icons.settings,
              color: Colors.white,
              size: 35,
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/appbar.jpg"), fit: BoxFit.cover)),
        ),
      ),
      body: Row(
        children: [
          Expanded(
              flex: 4,
              child: InkWell(
                onTap: () {
                  context.read<MainCubit>().closeEndDrawer();
                },
              )),
          Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 71, 71, 71)
                          .withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 15, bottom: 15),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey))),
                            child: InkWell(
                              onTap: () {
                                context.push(MainRouterPath.routerChangePass);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Change password",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 15, bottom: 15),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey))),
                            child: InkWell(
                              onTap: () {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const TermScreen(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Term",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 15, bottom: 15),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey))),
                            child: InkWell(
                              onTap: () {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const PolicyScreen(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Policy",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )),
                    const ButtonLogoutWdget(),
                    const SizedBox(height: 10),
                    const ButtonDeleteAccountWdget(),
                    const SizedBox(height: 50),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
