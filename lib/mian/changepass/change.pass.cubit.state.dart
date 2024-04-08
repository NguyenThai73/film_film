// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ChangePassCubitState extends Equatable {
  final Status status;
  const ChangePassCubitState({
    required this.status,
  });

  ChangePassCubitState copyWith({
    Status? status,
    String? avatarUrl,
    String? name,
  }) {
    return ChangePassCubitState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}

enum Status { initial, loading, success, error }
