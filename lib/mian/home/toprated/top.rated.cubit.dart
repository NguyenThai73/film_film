// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repository/repository.movie.dart';
import 'top.rated.cubit.state.dart';

class TopRatedCubit extends Cubit<TopRatedCubitState> {
  final RepositoryMovie repositoryMovie;
    final ScrollController scrollController = ScrollController();
  TopRatedCubit({required this.repositoryMovie})
      : super(
            const TopRatedCubitState(status: Status.initial, listMovie: [])) {
    getData();
  }
  getData() async {
    emit(state.copyWith(status: Status.loading));
    await repositoryMovie.getTopRated();
    if (repositoryMovie.listTopRated != null &&
        repositoryMovie.listTopRated?.results != null &&
        repositoryMovie.listTopRated!.results!.isNotEmpty) {
      if (repositoryMovie.listTopRated!.results!.length > 10) {
        emit(state.copyWith(
            status: Status.success,
            listMovie:
                repositoryMovie.listTopRated!.results!.sublist(0, 20)));
      } else {
        emit(state.copyWith(
            status: Status.success,
            listMovie: repositoryMovie.listTopRated!.results!));
      }
    } else {
      emit(state.copyWith(status: Status.success, listMovie: []));
    }
  }
}
