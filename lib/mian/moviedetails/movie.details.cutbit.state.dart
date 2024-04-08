// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:service_movie/service_movie.dart';

class MovieDetailsCubitState extends Equatable {
  final Status status;
  final MovieDetailsModel model;
  final List<Cast> listCast;
  final List<Video> listVideo;
  const MovieDetailsCubitState({
    required this.status,
    required this.model,
    required this.listCast,
    required this.listVideo,
  });

  MovieDetailsCubitState copyWith({
    Status? status,
    MovieDetailsModel? model,
    List<Cast>? listCast,
    List<Video>? listVideo,
  }) {
    return MovieDetailsCubitState(
      status: status ?? this.status,
      model: model ?? this.model,
      listCast: listCast ?? this.listCast,
      listVideo: listVideo ?? this.listVideo,
    );
  }

  @override
  List<Object> get props =>
      [status, model, listCast, listCast.length, listVideo, listVideo.length];
}

enum Status { initial, loading, success, error }
