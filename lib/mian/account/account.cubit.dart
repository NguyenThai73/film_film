// ignore_for_file: public_member_api_docs, sort_constructors_first, implementation_imports, depend_on_referenced_packages
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:film_film/repository/authentication.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_user/service_user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'account.cubit.state.dart';

class AccountCubit extends Cubit<AccountCubitState> {
  final GlobalKey<FormState> keyFrom = GlobalKey<FormState>();
  final AuthenticationRepository authenticationRepository;
  final UserModel userModel;
  final TextEditingController nameController = TextEditingController();

  AccountCubit(
      {required this.userModel, required this.authenticationRepository})
      : super(AccountCubitState(
            accountStatus: AccountStatus.initial, name: userModel.name ?? "")) {
    nameController.text = userModel.name ?? "";
  }

  Future<String?> handleUploadImage() async {
    String? fileName;
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      try {
        String fileName = result.files.first.name;
        String path = result.files.first.path ?? "";
        await FirebaseStorage.instance
            .ref('Images/$fileName')
            .putFile(File(path));
        return "https://firebasestorage.googleapis.com/v0/b/mxh123-21fe3.appspot.com/o/Images%2F$fileName?alt=media";
      } catch (e) {
        print("Error: $e");
      }
    } else {}
    return fileName;
  }

  uploadImage() async {
    emit(state.copyWith(accountStatus: AccountStatus.loading));
    var image = await handleUploadImage();
    emit(
        state.copyWith(accountStatus: AccountStatus.initial, avatarUrl: image));
  }

  updateInfor() async{
    emit(state.copyWith(accountStatus: AccountStatus.loading));
    await authenticationRepository.updateName(nameController.text);
    if (state.avatarUrl != null) {
     await authenticationRepository.updateImage(imageUrl: state.avatarUrl);
    }
    emit(state.copyWith(
      accountStatus: AccountStatus.success,
    ));
  }
}
