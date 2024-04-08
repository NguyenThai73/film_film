// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../constants/border_textfield.dart';
import '../../constants/button.not.click.multi.dart';
import '../../constants/component/error/error.cubit.dart';
import '../../constants/component/error/error.model.dart';
import '../../constants/component/error/error.widget.dart';
import '../../constants/component/loading/loading.cubit.dart';
import '../account/component/noti.update.success.dart';
import 'change.pass.cubit.dart';
import 'change.pass.cubit.state.dart';

class ChangePassPage extends StatelessWidget {
  const ChangePassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePassCubit, ChangePassCubitState>(
      listener: (context, state) {
        if (state.status == Status.loading) {
          context.read<LoadingCubit>().makeLoading();
        } else {
          context.read<LoadingCubit>().makeNoneLoading();
        }
        if (state.status == Status.success) {
          context
              .read<ErrorCubit>()
              .showDialog(widgetShow: const NotiUpdateSuccess());
        }
        if (state.status == Status.error) {
          context.read<ErrorCubit>().showDialog(
              widgetShow: ErrorWidgetApp(
                  errorModel: ErrorModel(title: "Change password error")));
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
                  "Change Password Page",
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
                    SizedBox(height: 20),
                    BorderTextField(
                      controller: context.read<ChangePassCubit>().password,
                      title: "Password",
                      placeholder: 'Enter your password',
                      isPassword: true,
                      onChangeText: (value) {},
                    ),
                    SizedBox(height: 20),
                    BorderTextField(
                      controller:
                          context.read<ChangePassCubit>().comfirmpassword,
                      title: "Comfirm password",
                      placeholder: 'Enter your comfirm password',
                      isPassword: true,
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
                  if (context.read<ChangePassCubit>().password.text.isEmpty ||
                      context
                          .read<ChangePassCubit>()
                          .comfirmpassword
                          .text
                          .isEmpty) {
                    context.read<ErrorCubit>().showDialog(
                        widgetShow: ErrorWidgetApp(
                            errorModel: ErrorModel(
                                title:
                                    "The information needs to be filled in completely.")));
                  } else if (context
                              .read<ChangePassCubit>()
                              .password
                              .text
                              .length <
                          6 ||
                      context
                              .read<ChangePassCubit>()
                              .comfirmpassword
                              .text
                              .length <
                          6) {
                    context.read<ErrorCubit>().showDialog(
                        widgetShow: ErrorWidgetApp(
                            errorModel: ErrorModel(
                                title:
                                    "The password must be at least 6 characters.")));
                  } else if (context.read<ChangePassCubit>().password.text !=
                      context.read<ChangePassCubit>().comfirmpassword.text) {
                    context.read<ErrorCubit>().showDialog(
                        widgetShow: ErrorWidgetApp(
                            errorModel: ErrorModel(
                                title:
                                    "The re-entered password does not match.")));
                  } else {
                    context.read<ChangePassCubit>().changepass();
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
