import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
class GifChatModel {
  final String? id;
  final String? createTime;
  final String? image;
  final String? createUserId;
  final String? createUserName;

  GifChatModel({
    this.id,
    this.createTime,
    this.image,
    this.createUserId,
    this.createUserName,
  });

  GifChatModel copyWith({
    String? id,
    String? createTime,
    String? image,
    String? createUserId,
    String? createUserName,
  }) {
    return GifChatModel(
      id: id ?? this.id,
      createTime: createTime ?? this.createTime,
      image: image ?? this.image,
      createUserId: createUserId ?? this.createUserId,
      createUserName: createUserName ?? this.createUserName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createTime': createTime,
      'image': image,
      'createUserId': createUserId,
      'createUserName': createUserName,
    };
  }

  factory GifChatModel.fromMap(Map<String, dynamic> map) {
    return GifChatModel(
      id: map['id'] != null ? map['id'] as String : null,
      createTime: map['createTime'] != null ? map['createTime'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      createUserId: map['createUserId'] != null ? map['createUserId'] as String : null,
      createUserName: map['createUserName'] != null ? map['createUserName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GifChatModel.fromJson(String source) => GifChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
