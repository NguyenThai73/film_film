// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repository/repository.movie.dart';
import 'now.playing.cubit.state.dart';

class NowPlayingCubit extends Cubit<NowPlayingCubitState> {
  final RepositoryMovie repositoryMovie;
    final ScrollController scrollController = ScrollController();
  NowPlayingCubit({required this.repositoryMovie})
      : super(
            const NowPlayingCubitState(status: Status.initial, listMovie: [])) {
    getData();
  }
  getData() async {
    emit(state.copyWith(status: Status.loading));
    await repositoryMovie.getNowPlaying();
    if (repositoryMovie.listNowPlaying != null &&
        repositoryMovie.listNowPlaying?.results != null &&
        repositoryMovie.listNowPlaying!.results!.isNotEmpty) {
      if (repositoryMovie.listNowPlaying!.results!.length > 10) {
        emit(state.copyWith(
            status: Status.success,
            listMovie:
                repositoryMovie.listNowPlaying!.results!.sublist(0, 20)));
      } else {
        emit(state.copyWith(
            status: Status.success,
            listMovie: repositoryMovie.listNowPlaying!.results!));
      }
    } else {
      emit(state.copyWith(status: Status.success, listMovie: []));
    }
  }
}
