// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AccountCubitState extends Equatable {
  final AccountStatus accountStatus;
  final String? avatarUrl;
  final String name;
  const AccountCubitState({
    required this.accountStatus,
    this.avatarUrl,
    this.name = "",
  });

  AccountCubitState copyWith({
    AccountStatus? accountStatus,
    String? avatarUrl,
    String? name,
  }) {
    return AccountCubitState(
      accountStatus: accountStatus ?? this.accountStatus,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [accountStatus, avatarUrl, name];
}

enum AccountStatus { initial, loading, success, error }