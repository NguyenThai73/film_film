import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'gift.receive.cubit.dart';
import 'gift.receive.cubit.state.dart';

class GiftReceiveView extends StatelessWidget {
  const GiftReceiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftReceiveCubit, GiftReceiveCubitState>(
      buildWhen: (previous, current) =>
          previous.showGiftStatus != current.showGiftStatus,
      builder: (context, stateGiftReceiveCubit) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: (stateGiftReceiveCubit.showGiftStatus == ShowGiftStatus.show)
              ? Image.asset(
                  "assets/${stateGiftReceiveCubit.giftShow?.image}",
                  fit: BoxFit.fill,
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
