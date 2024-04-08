// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class HomeCubitState extends Equatable {
  final HomeStatus status;
  const HomeCubitState({
    required this.status,
  });

  HomeCubitState copyWith({
    HomeStatus? status,
  }) {
    return HomeCubitState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}

enum HomeStatus { initial, loading, success, reload, loadMore }
