import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:service_movie/src/models/videos.response.dart';
import 'models/cast.model.dart';
import 'models/get.list.cart.dart';
import 'models/movie.details.model.dart';
import 'models/movie.lists.model.dart';
import 'models/person_response.dart';
import 'models/search.model.dart';

class ServiceMove {
  final String token;
  ServiceMove({required this.token});

  Future<MovieListsModel?> getListNowPlaying({required int page}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      var client = http.Client();
      var response = await client.get(
          Uri.parse(
              'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=$page'),
          headers: headers);
      if (response.statusCode == 200) {
        MovieListsModel movieListsModel =
            MovieListsModel.fromJson(response.body);
        return movieListsModel;
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  Future<MovieListsModel?> getPopular({required int page}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      var client = http.Client();
      var response = await client.get(
          Uri.parse(
              'https://api.themoviedb.org/3/movie/popular?language=en-US&page=$page'),
          headers: headers);
      if (response.statusCode == 200) {
        MovieListsModel movieListsModel =
            MovieListsModel.fromJson(response.body);
        return movieListsModel;
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }


  Future<MovieListsModel?> getTopRated({required int page}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      var client = http.Client();
      var response = await client.get(
          Uri.parse(
              'https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=$page'),
          headers: headers);
      if (response.statusCode == 200) {
        MovieListsModel movieListsModel =
            MovieListsModel.fromJson(response.body);
        return movieListsModel;
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  Future<MovieListsModel?> getUpcoming({required int page}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      var client = http.Client();
      var response = await client.get(
          Uri.parse(
              'https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=$page'),
          headers: headers);
      if (response.statusCode == 200) {
        MovieListsModel movieListsModel =
            MovieListsModel.fromJson(response.body);
        return movieListsModel;
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  Future<MovieDetailsModel?> getMovieDetails({required int idMovie}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      var client = http.Client();
      var response = await client.get(
          Uri.parse(
              'https://api.themoviedb.org/3/movie/$idMovie?language=en-US'),
          headers: headers);
      if (response.statusCode == 200) {
        MovieDetailsModel movieModel =
            MovieDetailsModel.fromJson(response.body);
        return movieModel;
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<List<Cast>> getListCast({required int idMovie}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      var client = http.Client();
      var response = await client.get(
          Uri.parse(
              "https://api.themoviedb.org/3/movie/$idMovie/credits?language=en-US"),
          headers: headers);
      if (response.statusCode == 200) {
        GetListCast getListCast = GetListCast.fromJson(response.body);
        return getListCast.cast;
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<List<Video>> getListVideo({required int idMovie}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      var client = http.Client();
      var response = await client.get(
          Uri.parse(
              "https://api.themoviedb.org/3/movie/$idMovie/videos?language=en-US"),
          headers: headers);
      if (response.statusCode == 200) {
        VideosResponse videosResponse = VideosResponse.fromJson(
            json.decode(response.body) as Map<String, dynamic>);
        return videosResponse.results;
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<PersonResponse?> getPersonResponse({required int idPersion}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      var client = http.Client();
      var response = await client.get(
          Uri.parse(
              "https://api.themoviedb.org/3/person/$idPersion?language=en-US"),
          headers: headers);
      if (response.statusCode == 200) {
        PersonResponse personResponse = PersonResponse.fromJson(
            json.decode(response.body) as Map<String, dynamic>);
        return personResponse;
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<SearchModel?> getDataSearch(
      {required String findName, required int page}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      var client = http.Client();
      var response = await client.get(
          Uri.parse(
              "Https://api.themoviedb.org/3/search/movie?query=$findName&include_adult=false&language=en-US&page=$page"),
          headers: headers);
      if (response.statusCode == 200) {
        SearchModel personResponse = SearchModel.fromJson(response.body);
        return personResponse;
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
