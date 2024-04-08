// ignore_for_file: unused_field
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_movie/service_movie.dart';
import '../../../repository/repository.movie.dart';
import 'movie.details.cutbit.state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsCubitState> {
  final RepositoryMovie repositoryMovie;
  final MovieModel movieModel;
  MovieDetailsCubit({required this.repositoryMovie, required this.movieModel})
      : super(MovieDetailsCubitState(
          status: Status.initial,
          model: MovieDetailsModel(),
          listCast: [],
          listVideo: [],
        )) {
    getData();
  }
  getData() async {
    await Future.delayed(Duration(milliseconds: 100));
    emit(state.copyWith(status: Status.loading));
    var movieDetailsModel =
        await repositoryMovie.getMovieDetails(idMovie: movieModel.id ?? 0);
    var listCast =
        await repositoryMovie.getListCast(idMovie: movieModel.id ?? 0);
    var listVideo =
        await repositoryMovie.getListVideo(idMovie: movieModel.id ?? 0);
    if (movieDetailsModel != null) {
      emit(state.copyWith(
        status: Status.success,
        model: movieDetailsModel,
        listCast: listCast,
        listVideo: listVideo,
      ));
    } else {
      emit(state.copyWith(status: Status.error));
    }
  }
}
