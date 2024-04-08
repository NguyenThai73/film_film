// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_film/constants/dialog.show.image.assets.dart';
import 'package:film_film/constants/dialog.show.image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../constants/border_textfield.dart';
import '../../constants/button.not.click.multi.dart';
import '../../constants/component/error/error.cubit.dart';
import '../../constants/component/error/error.model.dart';
import '../../constants/component/error/error.widget.dart';
import '../../constants/component/loading/loading.cubit.dart';
import 'account.cubit.dart';
import 'account.cubit.state.dart';
import 'component/noti.update.success.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountCubitState>(
      listener: (context, state) {
        if (state.accountStatus == AccountStatus.loading) {
          context.read<LoadingCubit>().makeLoading();
        } else {
          context.read<LoadingCubit>().makeNoneLoading();
        }
        if (state.accountStatus == AccountStatus.success) {
          context
              .read<ErrorCubit>()
              .showDialog(widgetShow: const NotiUpdateSuccess());
        }
        if (state.accountStatus == AccountStatus.error) {
          context
              .read<ErrorCubit>()
              .showDialog(widgetShow: ErrorWidgetApp(errorModel: ErrorModel()));
        }
      },
      builder: (context, state) {
        return ButtonNotClickMulti(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            appBar: AppBar(
              leading: Row(
                children: [
                  SizedBox(width: 10),
                  ButtonNotClickMulti(
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ))
                ],
              ),
              title: Center(
                child: Text(
                  "Account Page",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
              actions: [
                SizedBox(width: 44),
              ],
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/appbar.jpg"),
                        fit: BoxFit.cover)),
              ),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      margin: EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ]),
                      child: InkWell(
                        onTap: () {
                          state.avatarUrl != null
                              ? context.showDialogImage(state.avatarUrl ?? "")
                              : context.read<AccountCubit>().userModel.image !=
                                      null
                                  ? context.showDialogImage(context
                                          .read<AccountCubit>()
                                          .userModel
                                          .image ??
                                      "")
                                  : context.showDialogImageAssets(
                                      "assets/noavatar.jpeg");
                        },
                        child: ClipOval(
                          child: state.avatarUrl != null
                              ? CachedNetworkImage(
                                  imageUrl: state.avatarUrl ?? "",
                                  fit: BoxFit.cover,
                                )
                              : context.read<AccountCubit>().userModel.image !=
                                      null
                                  ? CachedNetworkImage(
                                      imageUrl: context
                                              .read<AccountCubit>()
                                              .userModel
                                              .image ??
                                          "",
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset("assets/noavatar.jpeg"),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(50)),
                      child: ButtonNotClickMulti(
                          onTap: () {
                            context.read<AccountCubit>().uploadImage();
                          },
                          child: Icon(Icons.photo_camera)),
                    ),
                    BorderTextField(
                      controller: context.read<AccountCubit>().nameController,
                      title: "Name",
                      placeholder: 'Enter your name',
                      onChangeText: (value) {},
                    ),
                    SizedBox(height: 20),
                    BorderTextField(
                      controller: TextEditingController(
                          text: context.read<AccountCubit>().userModel.email ??
                              ""),
                      title: "Email",
                      placeholder: '',
                      enabled: false,
                      onChangeText: (value) {},
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              margin: EdgeInsets.only(
                  bottom: 30,
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 0, 8, 255),
                    Color.fromARGB(255, 0, 187, 255)
                  ], // Mảng màu để tạo dốc
                ),
              ),
              child: InkWell(
                onTap: () {
                  if (context
                      .read<AccountCubit>()
                      .nameController
                      .text
                      .isEmpty) {
                    context.read<ErrorCubit>().showDialog(
                        widgetShow: ErrorWidgetApp(
                            errorModel: ErrorModel(
                                title:
                                    "The information needs to be filled in completely.")));
                  } else {
                    context.read<AccountCubit>().updateInfor();
                  }
                },
                child: Center(
                  child: Text(
                    "Update",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
