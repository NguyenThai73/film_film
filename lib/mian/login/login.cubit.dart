// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_user/service_user.dart';

import '../../repository/authentication.repository.dart';
import 'login.cubit.state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  final AuthenticationRepository authenticationRepository;

  LoginCubit({required this.authenticationRepository})
      : super( LoginCubitState(
            status: LoginStatus.initial, userModel: UserModel()));

  Future<UserModel?> login(
      {required String email, required String pass}) async {
    return await authenticationRepository.login(
        email: email, password: pass);
  }
}
