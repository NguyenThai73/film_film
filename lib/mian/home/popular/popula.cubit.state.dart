// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:service_movie/service_movie.dart';

class PopulaCubitState extends Equatable {
  final Status status;
  final List<MovieModel> listMovie;
  const PopulaCubitState({
    required this.status,
    required this.listMovie,
  });

  PopulaCubitState copyWith({
    Status? status,
    List<MovieModel>? listMovie,
  }) {
    return PopulaCubitState(
      status: status ?? this.status,
      listMovie: listMovie ?? this.listMovie,
    );
  }

  @override
  List<Object> get props => [status, listMovie];
}

enum Status { initial, loading, success, error }
