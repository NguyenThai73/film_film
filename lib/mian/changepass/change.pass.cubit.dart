// ignore_for_file: public_member_api_docs, sort_constructors_first, implementation_imports, depend_on_referenced_packages
import 'package:film_film/repository/authentication.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'change.pass.cubit.state.dart';

class ChangePassCubit extends Cubit<ChangePassCubitState> {
  final AuthenticationRepository authenticationRepository;
  final TextEditingController password = TextEditingController();
  final TextEditingController comfirmpassword = TextEditingController();

  ChangePassCubit({required this.authenticationRepository})
      : super(ChangePassCubitState(
          status: Status.initial,
        ));

  void changepass() async {
    emit(state.copyWith(status: Status.loading));
    var check = await authenticationRepository.changePass(password.text);
    if (check) {
      emit(state.copyWith(status: Status.success));
    } else {
      emit(state.copyWith(status: Status.error));
    }
  }
}
