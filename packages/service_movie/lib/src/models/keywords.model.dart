// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class KeywordsModel {
  int? id;
  String? name;
  KeywordsModel({
    this.id,
    this.name,
  });

  KeywordsModel copyWith({
    int? id,
    String? name,
  }) {
    return KeywordsModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory KeywordsModel.fromMap(Map<String, dynamic> map) {
    return KeywordsModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory KeywordsModel.fromJson(String source) =>
      KeywordsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class GetKeywordsModel {
  int? id;
  List<KeywordsModel>? keywords;
  GetKeywordsModel({
    this.id,
    this.keywords,
  });

  GetKeywordsModel copyWith({
    int? id,
    List<KeywordsModel>? keywords,
  }) {
    return GetKeywordsModel(
      id: id ?? this.id,
      keywords: keywords ?? this.keywords,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'keywords':
          (keywords != null) ? keywords?.map((x) => x.toMap()).toList() : null,
    };
  }

  factory GetKeywordsModel.fromMap(Map<String, dynamic> map) {
    return GetKeywordsModel(
      id: map['id'] != null ? map['id'] as int : null,
      keywords: map['keywords'] != null
          ? List<KeywordsModel>.from(
              (map['keywords'] as List<int>).map<KeywordsModel?>(
                (x) => KeywordsModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetKeywordsModel.fromJson(String source) =>
      GetKeywordsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
