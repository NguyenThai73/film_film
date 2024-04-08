// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:service_movie/service_movie.dart';

class GetListCast {
  int id;
  List<Cast> cast;
  GetListCast({
    required this.id,
    required this.cast,
  });

  GetListCast copyWith({
    int? id,
    List<Cast>? cast,
  }) {
    return GetListCast(
      id: id ?? this.id,
      cast: cast ?? this.cast,
    );
  }


  factory GetListCast.fromMap(Map<String, dynamic> map) {
    return GetListCast(
      id: (map['id'] ?? 0) as int,
      cast: List<Cast>.from((map['cast'] as List<dynamic>).map<Cast>((x) => Cast.fromJson(x as Map<String,dynamic>),),),
    );
  }


  factory GetListCast.fromJson(String source) => GetListCast.fromMap(json.decode(source) as Map<String, dynamic>);
}
