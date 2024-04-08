// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:service_movie/service_movie.dart';

class SearchCubitState extends Equatable {
  final SearchStatus status;
  final List<MovieModel> listMovie;
  const SearchCubitState({
    required this.status,
    required this.listMovie,
  });

  SearchCubitState copyWith({
    SearchStatus? status,
    List<MovieModel>? listMovie,
  }) {
    return SearchCubitState(
      status: status ?? this.status,
      listMovie: listMovie ?? this.listMovie,
    );
  }

  @override
  List<Object?> get props => [status, listMovie, listMovie.length];
}

enum SearchStatus { initial, loading, success, error }
