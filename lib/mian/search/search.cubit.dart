// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/repository.movie.dart';
import 'search.cubit.state.dart';

class SearchCubit extends Cubit<SearchCubitState> {
  final RepositoryMovie repositoryMovie;
  final ScrollController scrollController = ScrollController();

  String qery = "";
  int page = 1;

  SearchCubit({required this.repositoryMovie})
      : super(const SearchCubitState(
            status: SearchStatus.initial, listMovie: [])) {
    scrollController.addListener(_onScroll);
  }
  getData({required String findName}) async {
    page = 1;
    qery = findName;
    emit(state.copyWith(status: SearchStatus.loading));
    var data =
        await repositoryMovie.getDataSearch(findName: findName, page: page);

    emit(state.copyWith(
        status: SearchStatus.success, listMovie: data?.results ?? []));
  }

  Future<void> _onScroll() async {
    if (state.status == SearchStatus.loading) {
      return;
    }
    emit(state.copyWith(status: SearchStatus.loading));
    if ((scrollController.position.extentAfter < 100) &&
        (scrollController.position.extentBefore > 0)) {
      page++;
      var data =
          await repositoryMovie.getDataSearch(findName: qery, page: page);
      emit(state.copyWith(
          status: SearchStatus.success,
          listMovie: [...state.listMovie, ...data?.results ?? []]));
    }
    if (scrollController.position.extentBefore < 200) {
      page = 1;
      var data =
          await repositoryMovie.getDataSearch(findName: qery, page: page);
      emit(state.copyWith(
          status: SearchStatus.success, listMovie: [...data?.results ?? []]));
    }
  }
}
