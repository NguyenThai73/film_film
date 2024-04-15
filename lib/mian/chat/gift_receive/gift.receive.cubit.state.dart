// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:film_film/mian/chat/gift_receive/gif.model.dart';

class GiftReceiveCubitState extends Equatable {
  final ShowGiftStatus showGiftStatus;
  final GifChatModel? giftShow;

  const GiftReceiveCubitState({
    this.showGiftStatus = ShowGiftStatus.initial,
    this.giftShow,
  });

  GiftReceiveCubitState copyWith({
    List<GifChatModel>? lastGift,
    ShowGiftStatus? showGiftStatus,
    GifChatModel? giftShow,
  }) {
    return GiftReceiveCubitState(
      showGiftStatus: showGiftStatus ?? this.showGiftStatus,
      giftShow: giftShow ?? this.giftShow,
    );
  }

  @override
  List<Object?> get props => [showGiftStatus, giftShow];
}

enum ShowGiftStatus { initial, show, hide }
