// ignore_for_file: use_build_context_synchronously, deprecated_member_use, prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../constants/border_textfield.dart';
import '../../constants/button.not.click.multi.dart';
import '../../constants/component/error/error.cubit.dart';
import '../../constants/component/error/error.model.dart';
import '../../constants/component/error/error.widget.dart';
import '../../constants/component/loading/loading.cubit.dart';
import '../../constants/share.preference.dart';
import '../login/policy.screen.dart';
import '../login/term.screen.dart';
import 'register.cubit.dart';
import 'register.cubit.state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isAgree = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController comfirmPassController = TextEditingController();
  @override
  void initState() {
    checkAgree();
    super.initState();
  }

  checkAgree() async {
    var getData = await MySharedPreferences.getAgreeTerms();
    setState(() {
      isAgree = getData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterCubitState>(
      builder: (context, state) {
        if (state.status == LoginStatus.error) {
          context
              .read<ErrorCubit>()
              .showDialog(widgetShow: ErrorWidgetApp(errorModel: ErrorModel()));
        }
        return ButtonNotClickMulti(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/b1.jpeg"), fit: BoxFit.cover)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 15),
                          BorderTextField(
                            controller: nameController,
                            title: "Full name",
                            placeholder: 'Enter your name',
                            onChangeText: (value) {},
                          ),
                          const SizedBox(height: 15),
                          BorderTextField(
                            controller: emailController,
                            title: "Email",
                            placeholder: 'Enter your email',
                            onChangeText: (value) {},
                          ),
                          const SizedBox(height: 15),
                          BorderTextField(
                            controller: passwordController,
                            title: "Password",
                            placeholder: 'Enter your password',
                            isPassword: true,
                            onChangeText: (value) {},
                          ),
                          const SizedBox(height: 15),
                          BorderTextField(
                            controller: comfirmPassController,
                            title: "Confirm password",
                            placeholder: 'Enter your confirm password',
                            isPassword: true,
                            onChangeText: (value) {},
                          ),
                          const SizedBox(height: 15),
                          Container(
                            margin: const EdgeInsets.only(top: 15),
                            height: 56,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 122, 213, 255),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      if (!isAgree) {
                                        context.read<ErrorCubit>().showDialog(
                                            widgetShow: ErrorWidgetApp(
                                                errorModel: ErrorModel(
                                                    title:
                                                        "You need to agree to our terms and conditions, usage policies in order to proceed.")));
                                        return;
                                      }
                                      context
                                          .read<LoadingCubit>()
                                          .makeLoading();
                                      if (nameController.text.isEmpty ||
                                          emailController.text.isEmpty ||
                                          passwordController.text.isEmpty ||
                                          comfirmPassController.text.isEmpty) {
                                        context.read<ErrorCubit>().showDialog(
                                            widgetShow: ErrorWidgetApp(
                                                errorModel: ErrorModel(
                                                    title:
                                                        "The information needs to be filled in completely.")));
                                      } else {
                                        if (passwordController.text.length <
                                                5 ||
                                            comfirmPassController.text.length <
                                                5) {
                                          context.read<ErrorCubit>().showDialog(
                                              widgetShow: ErrorWidgetApp(
                                                  errorModel: ErrorModel(
                                                      title:
                                                          "The password must be at least 6 characters.")));
                                        } else {
                                          if (passwordController.text !=
                                              comfirmPassController.text) {
                                            context.read<ErrorCubit>().showDialog(
                                                widgetShow: ErrorWidgetApp(
                                                    errorModel: ErrorModel(
                                                        title:
                                                            "The re-entered password does not match.")));
                                          } else {
                                            var response = await context
                                                .read<RegisterCubit>()
                                                .register(
                                                    email: emailController.text,
                                                    password:
                                                        passwordController.text,
                                                    name: nameController.text);

                                            if (!response) {
                                              context.read<ErrorCubit>().showDialog(
                                                  widgetShow: ErrorWidgetApp(
                                                      errorModel: ErrorModel(
                                                          title:
                                                              "Registration error.")));
                                            }
                                          }
                                        }
                                      }
                                      context
                                          .read<LoadingCubit>()
                                          .makeNoneLoading();
                                    },
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Do you already have an account? ",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              ButtonNotClickMulti(
                                  onTap: () {
                                    context.pop();
                                  },
                                  child: Text("Login",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w700)))
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.blue,
                                value: isAgree,
                                onChanged: (bool? value) async {
                                  await MySharedPreferences.saveAgreeTerms(
                                      value ?? false);
                                  setState(() {
                                    isAgree = value!;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                      style: TextStyle(fontSize: 16),
                                      children: [
                                        TextSpan(
                                          text: "I have read and agree to the ",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "terms",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor: Colors.blue),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push<void>(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder:
                                                      (BuildContext context) =>
                                                          const TermScreen(),
                                                ),
                                              );
                                            },
                                        ),
                                        TextSpan(
                                          text: " and ",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "policies",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor: Colors.blue),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push<void>(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder:
                                                      (BuildContext context) =>
                                                          const PolicyScreen(),
                                                ),
                                              );
                                            },
                                        ),
                                        TextSpan(
                                          text: " of Find Favorite Movies.",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
