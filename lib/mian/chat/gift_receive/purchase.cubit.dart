// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'purchase.cubit.state.dart';

class PurchaseCubit extends Cubit<PurchaseCubitState> {
  final InAppPurchase inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  String kConsumableId = "";
  bool verifyPurchase = false;

  PurchaseCubit() : super(const PurchaseCubitState(status: Status.initial)) {
    _subscription = inAppPurchase.purchaseStream.listen(
        (List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      print("onError: ${error}");
    });
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      print("purchaseDetails: ${purchaseDetails.status}");
      if (purchaseDetails.status == PurchaseStatus.pending) {
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          emit(state.copyWith(status: Status.error));
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          verifyPurchase = true;
        }
        if (purchaseDetails.pendingCompletePurchase) {
          handleCompletePurchase(purchaseDetails);
        }
      }
    }
  }

  purchaseProduct(String productId) async {
    emit(state.copyWith(status: Status.loading));
    try {
      bool available = await inAppPurchase.isAvailable();
      if (!available) {
        emit(state.copyWith(status: Status.error));
        return;
      }
      kConsumableId = productId;
      final ProductDetailsResponse productDetailsResponse =
          await inAppPurchase.queryProductDetails({kConsumableId});
      print(
          "productDetailsResponse notFoundIDs: ${productDetailsResponse.notFoundIDs}");
      print(
          "productDetailsResponse productDetails: ${productDetailsResponse.productDetails}");
      if (productDetailsResponse.notFoundIDs.contains(kConsumableId)) {
        emit(state.copyWith(status: Status.error));
        return;
      }
      final ProductDetails productDetails =
          productDetailsResponse.productDetails.first;
      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: productDetails);
      await inAppPurchase.buyConsumable(
          purchaseParam: purchaseParam, autoConsume: true);
    } catch (e) {
      print("Looiiiiiiii: ${e}");
      emit(state.copyWith(status: Status.error));
    }
  }

  handleCompletePurchase(PurchaseDetails purchaseDetails) async {
    await inAppPurchase.completePurchase(purchaseDetails);
    if (state.status == Status.loading) {
      if (verifyPurchase) {
        verifyPurchase = false;
        try {} catch (e) {
          print("Loiii: $e");
        }
        emit(state.copyWith(status: Status.success));
      } else {
        emit(state.copyWith(status: Status.initial));
      }
    }
  }
}
