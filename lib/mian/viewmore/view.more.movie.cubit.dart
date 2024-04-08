import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_movie/service_movie.dart';

import '../../constants/list.load.state.dart';
import '../../repository/repository.movie.dart';

class ViewMoreMovieCubit extends Cubit<ListLoadState<MovieModel>> {
  final TypeViewMore typeViewMore;
  final RepositoryMovie repositoryMovie;
  final ScrollController scrollController = ScrollController();

  ViewMoreMovieCubit(
      {required this.repositoryMovie, required this.typeViewMore})
      : super(const ListLoadState()) {
    getData();
    scrollController.addListener(_onScroll);
  }
  getData() {
    emit(state.copyWith(
        list: typeViewMore == TypeViewMore.popular
            ? repositoryMovie.listPopular?.results ?? []
            : typeViewMore == TypeViewMore.nowPlaying
                ? repositoryMovie.listNowPlaying?.results ?? []
                : typeViewMore == TypeViewMore.topRated
                    ? repositoryMovie.listTopRated?.results ?? []
                    : typeViewMore == TypeViewMore.upcoming
                        ? repositoryMovie.listUpcoming?.results ?? []
                        : []));
  }

  Future<void> _onScroll() async {}
}

enum TypeViewMore { popular, nowPlaying, topRated, upcoming }

extension NumberConvert on TypeViewMore {
  String get namePage {
    switch (this) {
      case TypeViewMore.popular:
        return "Popular";
      case TypeViewMore.nowPlaying:
        return "Now Playing";
      case TypeViewMore.topRated:
        return "Top Rated";
      case TypeViewMore.upcoming:
        return "Upcoming";
      default:
        return "";
    }
  }
}
