// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_user/service_user.dart';

import '../../repository/authentication.repository.dart';
import 'register.cubit.state.dart';

class RegisterCubit extends Cubit<RegisterCubitState> {
  final AuthenticationRepository authenticationRepository;
  final GlobalKey<FormState> keyFrom = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController comfirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();

  RegisterCubit({required this.authenticationRepository})
      : super(RegisterCubitState(
            status: LoginStatus.initial, userModel: UserModel()));

  get validatorConfirmPass => (String? text) {
        if (comfirmPasswordController.text.isEmpty) {
          return "Not null!";
        }
        if (passwordController.text != comfirmPasswordController.text) {
          return "Not right!";
        }
        return null;
      };

  bool checkForm() {
    return keyFrom.currentState?.validate() ?? false;
  }

  Future<bool> register({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(state.copyWith(status: LoginStatus.loading));
    var response = await authenticationRepository.register(
        email: email, password: password, name: name);
    if (response == null) {
      // emit(state.copyWith(status: LoginStatus.error));
      return false;
    } else {
      // emit(state.copyWith(status: LoginStatus.success));
      return true;
    }
  }
}
