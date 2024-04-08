// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat.cubit.state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'provider/chat.provider.dart';
import 'provider/message.model.dart';

class ChatCubit extends Cubit<ChatCubitState> {
  final FocusNode chatFocus = FocusNode();
  final TextEditingController controllerChat = TextEditingController();
  List<String> listBlackWork = [];
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  ChatCubit() : super(const ChatCubitState()) {
    chatFocus.addListener(() {
      if (chatFocus.hasFocus) {
        emit(state.copyWith(status: CommentStatus.focusComment));
      } else {
        emit(state.copyWith(status: CommentStatus.initial));
      }
    });
    getListBackWork();
  }
  getListBackWork() async {
    listBlackWork = await ChatProvider().getListBlackWork();
  }

  Future<bool> sendText(MessageModel messageModel) async {
    chatFocus.unfocus();
    if (controllerChat.text.isEmpty) {
      return true;
    }
    var validateChat = validate();
    if (!validateChat) {
      String content = controllerChat.text;
      controllerChat.clear();
      await ChatProvider().sendChat(messageModel.copyWith(message: content));
      return true;
    } else {
      return false;
    }
  }

  Future<void> sendImage(MessageModel messageModele) async {
    await ChatProvider().sendChat(messageModele);
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

  Future<void> reportMessage(
      {required String userReport, required String messageReport}) async {
    await ChatProvider()
        .reportMessage(userReport: userReport, messageReport: messageReport);
  }

  bool validate() {
    for (var element in listBlackWork) {
      if (controllerChat.text.toUpperCase().contains(element)) {
        return true;
      }
    }
    return false;
  }
}
