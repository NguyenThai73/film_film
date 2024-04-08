import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_film/constants/button.not.click.multi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:service_user/service_user.dart';

import '../main.router.constant.dart';
import '../mian/cubit/user.change.cubit.dart';

class AvartarApp extends StatelessWidget {
  const AvartarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserChangeCubit, UserModel?>(
      builder: (context, state) {
        return SizedBox(
          width: 40,
          height: 40,
          child: ButtonNotClickMulti(
            onTap: () {
              context.push(MainRouterPath.routerAccout);
            },
            child: ClipOval(
              child: (state?.image == null)
                  ? Image.asset(
                      "assets/noavatar.jpeg",
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: state?.image ?? "",
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(),
                    ),
            ),
          ),
        );
      },
    );
  }
}
