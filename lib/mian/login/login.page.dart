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
import '../../main.router.constant.dart';
import 'login.cubit.dart';
import 'login.cubit.state.dart';
import 'policy.screen.dart';
import 'term.screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAgree = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String username = "";
  String password = "";
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
    return BlocBuilder<LoginCubit, LoginCubitState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async => false,
          child: ButtonNotClickMulti(
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
                              controller: emailController,
                              title: "Email",
                              placeholder: 'Enter your email',
                              onChangeText: (value) {
                                username = value;
                              },
                            ),
                            const SizedBox(height: 15),
                            BorderTextField(
                              controller: passwordController,
                              title: "Password",
                              placeholder: 'Enter your password',
                              isPassword: true,
                              onChangeText: (value) {
                                password = value;
                              },
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
                                    child: Container(
                                      decoration: BoxDecoration(),
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
                                          if (emailController.text.isEmpty ||
                                              passwordController.text.isEmpty) {
                                            context.read<ErrorCubit>().showDialog(
                                                widgetShow: ErrorWidgetApp(
                                                    errorModel: ErrorModel(
                                                        title:
                                                            "The information needs to be filled in completely.")));
                                          } else {
                                            var response = await context
                                                .read<LoginCubit>()
                                                .login(
                                                    email: emailController.text,
                                                    pass: passwordController
                                                        .text);
                                            if (response == null) {
                                              context.read<ErrorCubit>().showDialog(
                                                  widgetShow: ErrorWidgetApp(
                                                      errorModel: ErrorModel(
                                                          title:
                                                              "The email or password is incorrect.")));
                                            }
                                          }
                                          context
                                              .read<LoadingCubit>()
                                              .makeNoneLoading();
                                        },
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ),
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
                                  "Do not have an account? ",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                ButtonNotClickMulti(
                                    onTap: () {
                                      context
                                          .push(MainRouterPath.routerRegister);
                                    },
                                    child: Text("Register",
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
                                            text:
                                                "I have read and agree to the ",
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
                                                    builder: (BuildContext
                                                            context) =>
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
                                                    builder: (BuildContext
                                                            context) =>
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
          ),
        );
      },
    );
  }
}
