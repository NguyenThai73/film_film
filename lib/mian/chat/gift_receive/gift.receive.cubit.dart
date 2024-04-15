// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../provider/chat.provider.dart';
import 'gif.model.dart';
import 'gift.receive.cubit.state.dart';

class GiftReceiveCubit extends Cubit<GiftReceiveCubitState> {
  final timeGiftReceive = 5;
  Timer? timer;
  final List<GifChatModel> listGift;
  late StreamSubscription<GifChatModel> streamGift;
  bool isPlayingGift = false;
  bool isFirst = true;

  GiftReceiveCubit()
      : listGift = [],
        super(const GiftReceiveCubitState()) {
    getStreamGift();
  }

  @override
  Future<void> close() async {
    streamGift.cancel();
    return super.close();
  }

  void getStreamGift() async {
    streamGift = ChatProvider().giftStream().listen((event) {
      if (isFirst) {
        isFirst = false;
      } else {
        if (event.id != null) {
          listGift.add(event);
          if (listGift.length == 1 &&
              state.showGiftStatus != ShowGiftStatus.show) {
            handleShowGif();
          }
        }
      }
    });
  }

  void handleShowGif() async {
    if (listGift.isNotEmpty && !isClosed) {
      emit(state.copyWith(
          showGiftStatus: ShowGiftStatus.show, giftShow: listGift.first));
      isPlayingGift = true;
      playGif();
    }
  }

  void playGif() async {
    if (!isClosed &&
        state.showGiftStatus == ShowGiftStatus.show &&
        isPlayingGift) {
      isPlayingGift = false;
      await Future.delayed(const Duration(seconds: 8));
      emit(state.copyWith(showGiftStatus: ShowGiftStatus.hide));
      listGift.removeAt(0);
      handleShowGif();
    }
  }
}
