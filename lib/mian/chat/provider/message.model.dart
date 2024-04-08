// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  String? id;
  String? message;
  String? type;
  String? linkFile;
  String? createTime;
  String? fileName;
  String? createUserId;
  String? createUserName;
  String? createUserImage;
  MessageModel({
    this.id,
    this.message,
    this.type,
    this.linkFile,
    this.createTime,
    this.fileName,
    this.createUserId,
    this.createUserName,
    this.createUserImage,
  });

  MessageModel copyWith({
    String? id,
    String? message,
    String? type,
    String? linkFile,
    String? createTime,
    String? fileName,
    String? createUserId,
    String? createUserName,
    String? createUserImage,
  }) {
    return MessageModel(
      id: id ?? this.id,
      message: message ?? this.message,
      type: type ?? this.type,
      linkFile: linkFile ?? this.linkFile,
      createTime: createTime ?? this.createTime,
      fileName: fileName ?? this.fileName,
      createUserId: createUserId ?? this.createUserId,
      createUserName: createUserName ?? this.createUserName,
      createUserImage: createUserImage ?? this.createUserImage,
    );
  }

  Map<String, dynamic> toMapClass() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'type': type,
      'linkFile': linkFile,
      'createTime': createTime,
      'fileName': fileName,
      'createUserId': createUserId,
      'createUserName': createUserName,
      'createUserImage': createUserImage,
    };
  }

  Map<String, dynamic> toMapGroup() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'type': type,
      'linkFile': linkFile,
      'createTime': createTime,
      'fileName': fileName,
      'createUserId': createUserId,
      'createUserName': createUserName,
      'createUserImage': createUserImage,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] != null ? map['id'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      linkFile: map['linkFile'] != null ? map['linkFile'] as String : null,
      createTime: map['createTime'] != null ? map['createTime'] as String : null,
      fileName: map['fileName'] != null ? map['fileName'] as String : null,
      createUserId: map['createUserId'] != null ? map['createUserId'] as String : null,
      createUserName: map['createUserName'] != null ? map['createUserName'] as String : null,
      createUserImage: map['createUserImage'] != null ? map['createUserImage'] as String : null,
    );
  }

  String toJsonClass() => json.encode(toMapClass());
  String toJsonGroup() => json.encode(toMapGroup());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'type': type,
      'linkFile': linkFile,
      'createTime': createTime,
      'fileName': fileName,
      'createUserId': createUserId,
      'createUserName': createUserName,
      'createUserImage': createUserImage,
    };
  }

  String toJson() => json.encode(toMap());
}
