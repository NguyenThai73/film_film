// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class PurchaseCubitState extends Equatable {
  final Status status;

  const PurchaseCubitState({
    this.status = Status.initial,
  });

  PurchaseCubitState copyWith({
    Status? status,
  }) {
    return PurchaseCubitState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}

enum Status { initial, loading, success, error }
