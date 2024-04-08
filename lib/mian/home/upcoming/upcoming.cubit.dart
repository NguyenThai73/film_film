// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repository/repository.movie.dart';
import 'upcoming.cubit.state.dart';

class UpcomingCubit extends Cubit<UpcomingCubitState> {
  final RepositoryMovie repositoryMovie;
  final ScrollController scrollController = ScrollController();
  UpcomingCubit({required this.repositoryMovie})
      : super(const UpcomingCubitState(status: Status.initial, listMovie: [])) {
    getData();
  }
  getData() async {
    emit(state.copyWith(status: Status.loading));
    await repositoryMovie.getUpcoming();
    if (repositoryMovie.listUpcoming != null &&
        repositoryMovie.listUpcoming?.results != null &&
        repositoryMovie.listUpcoming!.results!.isNotEmpty) {
      if (repositoryMovie.listUpcoming!.results!.length > 10) {
        emit(state.copyWith(
            status: Status.success,
            listMovie: repositoryMovie.listUpcoming!.results!.sublist(0, 20)));
      } else {
        emit(state.copyWith(
            status: Status.success,
            listMovie: repositoryMovie.listUpcoming!.results!));
      }
    } else {
      emit(state.copyWith(status: Status.success, listMovie: []));
    }
  }
}
