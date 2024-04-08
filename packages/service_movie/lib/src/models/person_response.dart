// To parse this JSON data, do
//
//     final personResponse = personResponseFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

PersonResponse personResponseFromJson(String str) =>
    PersonResponse.fromJson(json.decode(str));

class PersonResponse {
  PersonResponse({
    required this.adult,
    required this.alsoKnownAs,
    required this.biography,
    this.birthday,
    required this.deathday,
    required this.gender,
    this.homepage,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    required this.profilePath,
  });

  bool adult;
  List<String> alsoKnownAs;
  String biography;
  DateTime? birthday;
  dynamic deathday;
  int gender;
  String? homepage;
  int id;
  String imdbId;
  String knownForDepartment;
  String name;
  String placeOfBirth;
  double popularity;
  String profilePath;

  get fullProfileImg {
    if (profilePath.isNotEmpty) {
      return 'https://image.tmdb.org/t/p/w500$profilePath';
    }
    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  get formatBirthday {
    return birthday != null ? DateFormat('dd-MM-yyyy').format(birthday!) : "";
  }

  factory PersonResponse.fromJson(Map<String, dynamic> json) => PersonResponse(
        adult: json["adult"] ?? false,
        alsoKnownAs: List<String>.from(json["also_known_as"].map((x) => x)),
        biography: json["biography"] ?? "",
        birthday:
            json["birthday"] != null ? DateTime.parse(json["birthday"]) : null,
        deathday: json["deathday"] ?? "",
        gender: json["gender"] ?? 0,
        homepage: json["homepage"] ?? "",
        id: json["id"] ?? 0,
        imdbId: json["imdb_id"],
        knownForDepartment: json["known_for_department"] ?? "",
        name: json["name"] ?? "",
        placeOfBirth: json["place_of_birth"] ?? "",
        popularity:
            json["popularity"] != null ? json["popularity"].toDouble() : 0,
        profilePath: json["profile_path"] ?? "",
      );
}
