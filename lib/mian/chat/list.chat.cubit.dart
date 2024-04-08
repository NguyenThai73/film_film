import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_user/service_user.dart';
import '../../constants/list.load.state.dart';
import 'provider/chat.provider.dart';
import 'provider/message.model.dart';

class ListChatCubit extends Cubit<ListLoadState<MessageModel>> {
  final UserModel userModel;
  bool isFirst = true;
  late StreamSubscription<MessageModel> _streamMessage;
  List<String> listBlock = [];

  ListChatCubit({required this.userModel}) : super(const ListLoadState()) {
    startStreamComment();
  }
  startStreamComment() async {
    await getListBlock(userModel.id ?? "");
    await getListComment();
    _streamMessage = ChatProvider().streamMessage().listen((event) async {
      if (isFirst) {
        isFirst = false;
      } else {
        String nameconver = event.createUserId ?? "";
        if (!listBlock.contains(nameconver)) {
          emit(state.copyWith(list: [event, ...state.list]));
        }
      }
    });
  }

  Future<void> getListComment() async {
    var listChat = await ChatProvider().getMessAll();
    List<MessageModel> listChatFilter = [];
    for (var element in listChat) {
      String nameconver = element.createUserId ?? "";
      if (!listBlock.contains(nameconver)) {
        listChatFilter.add(element);
      }
    }
    emit(state.copyWith(list: listChatFilter));
  }

  getListBlock(String userId) async {
    var listBlockNew = await ChatProvider().getListBlock(userId);
    listBlock = listBlockNew;
  }

  handleBlockUser({required String userIdIsBlock}) async {
    listBlock.add(userIdIsBlock);
    await ChatProvider()
        .addListBloc(userId: userModel.id ?? "", data: listBlock);
    List<MessageModel> listChatNew = [];
    for (var element in state.list) {
      String nameconver = element.createUserId ?? "";
      if (!listBlock.contains(nameconver)) {
        listChatNew.add(element);
      }
    }
    emit(state.copyWith(list: listChatNew));
  }

  @override
  Future<void> close() async {
    _streamMessage.cancel();
    return super.close();
  }
}
