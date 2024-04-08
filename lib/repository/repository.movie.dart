// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:service_movie/service_movie.dart';

class RepositoryMovie {
  MovieListsModel? listNowPlaying;
  MovieListsModel? listPopular;
  MovieListsModel? listTopRated;
  MovieListsModel? listUpcoming;

  RepositoryMovie({
    this.listNowPlaying,
  });

  final ServiceMove serviceMove = ServiceMove(
      token:
          "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ZmYwOWExZWU1YjBmZmY1MjEyOGY1YjVjNmExMWQ2NyIsInN1YiI6IjY1ZjE2MGQxZWVhMzRkMDEzMTEyMjQyOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hxjt7Zosnx6dzF84gQg3EjDfjlrgsLZB8AiRhDG0yME");

  getNowPlaying() async {
    var responseListNowPlaying1 = await serviceMove.getListNowPlaying(page: 1);
    var responseListNowPlaying2 = await serviceMove.getListNowPlaying(page: 2);
    var responseListNowPlaying3 = await serviceMove.getListNowPlaying(page: 3);
    var responseListNowPlaying4 = await serviceMove.getListNowPlaying(page: 4);
    var responseListNowPlaying5 = await serviceMove.getListNowPlaying(page: 5);
    var responseListNowPlaying6 = await serviceMove.getListNowPlaying(page: 6);
    var responseListNowPlaying7 = await serviceMove.getListNowPlaying(page: 7);
    var responseListNowPlaying8 = await serviceMove.getListNowPlaying(page: 8);
    var responseListNowPlaying9 = await serviceMove.getListNowPlaying(page: 9);
    var responseListNowPlaying10 =
        await serviceMove.getListNowPlaying(page: 10);

    listNowPlaying = responseListNowPlaying1?.copyWith(results: [
      ...responseListNowPlaying1.results ?? [],
      ...responseListNowPlaying2?.results ?? [],
      ...responseListNowPlaying3?.results ?? [],
      ...responseListNowPlaying4?.results ?? [],
      ...responseListNowPlaying5?.results ?? [],
      ...responseListNowPlaying6?.results ?? [],
      ...responseListNowPlaying7?.results ?? [],
      ...responseListNowPlaying8?.results ?? [],
      ...responseListNowPlaying9?.results ?? [],
      ...responseListNowPlaying10?.results ?? [],
    ]);
  }

  getPopular() async {
    var response1 = await serviceMove.getPopular(page: 1);
    var response2 = await serviceMove.getPopular(page: 2);
    var response3 = await serviceMove.getPopular(page: 3);
    var response4 = await serviceMove.getPopular(page: 4);
    var response5 = await serviceMove.getPopular(page: 5);
    var response6 = await serviceMove.getPopular(page: 6);
    var response7 = await serviceMove.getPopular(page: 7);
    var response8 = await serviceMove.getPopular(page: 8);
    var response9 = await serviceMove.getPopular(page: 9);
    var response10 = await serviceMove.getPopular(page: 10);

    listPopular = response1?.copyWith(results: [
      ...response1.results ?? [],
      ...response2?.results ?? [],
      ...response3?.results ?? [],
      ...response4?.results ?? [],
      ...response5?.results ?? [],
      ...response6?.results ?? [],
      ...response7?.results ?? [],
      ...response8?.results ?? [],
      ...response9?.results ?? [],
      ...response10?.results ?? [],
    ]);
  }

  getTopRated() async {
    var response1 = await serviceMove.getTopRated(page: 1);
    var response2 = await serviceMove.getTopRated(page: 2);
    var response3 = await serviceMove.getTopRated(page: 3);
    var response4 = await serviceMove.getTopRated(page: 4);
    var response5 = await serviceMove.getTopRated(page: 5);
    var response6 = await serviceMove.getTopRated(page: 6);
    var response7 = await serviceMove.getTopRated(page: 7);
    var response8 = await serviceMove.getTopRated(page: 8);
    var response9 = await serviceMove.getTopRated(page: 9);
    var response10 = await serviceMove.getTopRated(page: 10);

    listTopRated = response1?.copyWith(results: [
      ...response1.results ?? [],
      ...response2?.results ?? [],
      ...response3?.results ?? [],
      ...response4?.results ?? [],
      ...response5?.results ?? [],
      ...response6?.results ?? [],
      ...response7?.results ?? [],
      ...response8?.results ?? [],
      ...response9?.results ?? [],
      ...response10?.results ?? [],
    ]);
  }

  getUpcoming() async {
    var response1 = await serviceMove.getUpcoming(page: 1);
    var response2 = await serviceMove.getUpcoming(page: 2);
    var response3 = await serviceMove.getUpcoming(page: 3);
    var response4 = await serviceMove.getUpcoming(page: 4);
    var response5 = await serviceMove.getUpcoming(page: 5);
    var response6 = await serviceMove.getUpcoming(page: 6);
    var response7 = await serviceMove.getUpcoming(page: 7);
    var response8 = await serviceMove.getUpcoming(page: 8);
    var response9 = await serviceMove.getUpcoming(page: 9);
    var response10 = await serviceMove.getUpcoming(page: 10);

    listUpcoming = response1?.copyWith(results: [
      ...response1.results ?? [],
      ...response2?.results ?? [],
      ...response3?.results ?? [],
      ...response4?.results ?? [],
      ...response5?.results ?? [],
      ...response6?.results ?? [],
      ...response7?.results ?? [],
      ...response8?.results ?? [],
      ...response9?.results ?? [],
      ...response10?.results ?? [],
    ]);
  }

  Future<MovieDetailsModel?> getMovieDetails({required int idMovie}) async {
    return await serviceMove.getMovieDetails(idMovie: idMovie);
  }

  Future<List<Cast>> getListCast({required int idMovie}) async {
    return await serviceMove.getListCast(idMovie: idMovie);
  }

  Future<List<Video>> getListVideo({required int idMovie}) async {
    return await serviceMove.getListVideo(idMovie: idMovie);
  }

  Future<PersonResponse?> getPersonResponse({required int idPersion}) async {
    return await serviceMove.getPersonResponse(idPersion: idPersion);
  }

  Future<SearchModel?> getDataSearch(
      {required String findName, required int page}) async {
    return await serviceMove.getDataSearch(findName: findName, page: page);
  }
}
