import 'package:film_film/constants/button.not.click.multi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../mian/mian.cubit.dart';
import 'avar.dart';

class AppbarCustom extends StatelessWidget {
  final String titilePage;
  final Widget body;
  const AppbarCustom({super.key, required this.titilePage, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [SizedBox(width: 10), AvartarApp()],
        ),
        title: Center(
          child: Text(
            titilePage,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          ButtonNotClickMulti(
            onTap: (){
              context.read<MainCubit>().openEndDrawer();
            },
            child: Icon(
              Icons.settings,
              color: Colors.white,
              size: 35,
            ),
          ),
          SizedBox(width: 10),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/appbar.jpg"), fit: BoxFit.cover)),
        ),
      ),
      body: body,
    );
  }
}
