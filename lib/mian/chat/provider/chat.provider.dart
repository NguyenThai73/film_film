// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'message.model.dart';

class ChatProvider {
  final firebaseInstance = FirebaseFirestore.instance;
  final CollectionReference<Map<String, dynamic>> _chatCollection =
      FirebaseFirestore.instance.collection('chat');

  Future<List<MessageModel>> getMessAll() async {
    var result = await _chatCollection
        .orderBy("createTime", descending: true)
        .withConverter<MessageModel>(
          fromFirestore: (snapshot, options) =>
              MessageModel.fromMap(snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toMap(),
        )
        .get();
    return result.docs.map((e) => e.data()).toList();
  }

  sendChat(MessageModel messageModel) async {
    var idMess = const Uuid().v4();
    var time = DateTime.now().toUtc();
    _chatCollection.doc(idMess).set(messageModel
        .copyWith(
          id: idMess,
          createTime: time.toMyDateTime,
        )
        .toMap());
  }

  Stream<MessageModel> streamMessage() {
    return _chatCollection
        .orderBy("createTime", descending: true)
        .limit(1)
        .withConverter<MessageModel>(
          fromFirestore: (snapshot, options) {
            return MessageModel.fromMap(snapshot.data() ?? {});
          },
          toFirestore: (value, options) => value.toMap(),
        )
        .snapshots()
        .map((event) {
      var listChange = event.docChanges
          .where((element) => element.type == DocumentChangeType.added)
          .map((e) {
        return e.doc.data();
      }).toList();
      if (listChange.isEmpty) {
        return MessageModel();
      }
      return listChange.first!;
    });
  }

  reportMessage(
      {required String userReport, required String messageReport}) async {
    var idReport = const Uuid().v4();
    var time = DateTime.now().toUtc();
    await FirebaseFirestore.instance.collection("report").doc(idReport).set({
      "id": idReport,
      "createTime": time.toMyDateTime,
      "userReport": userReport,
      "messageReport": messageReport,
    });
  }

  // Stream<GifChatModel> giftStream() {
  //   return FirebaseFirestore.instance
  //       .collection('gift')
  //       .orderBy("createTime", descending: true)
  //       .limit(1)
  //       .withConverter<GifChatModel>(
  //         fromFirestore: (snapshot, options) =>
  //             GifChatModel.fromMap(snapshot.data() ?? {}),
  //         toFirestore: (value, options) => value.toMap(),
  //       )
  //       .snapshots()
  //       .map((event) {
  //     var listChange = event.docChanges
  //         .where((element) => element.type == DocumentChangeType.added)
  //         .map((e) {
  //       return e.doc.data();
  //     }).toList();
  //     if (listChange.isEmpty) {
  //       return GifChatModel();
  //     }
  //     return listChange.first!;
  //   });
  // }

  // sendGif(GifChatModel gifChatModel) async {
  //   var id = const Uuid().v4();
  //   var time = DateTime.now().toUtc();
  //   await FirebaseFirestore.instance.collection('gift').doc(id).set(gifChatModel
  //       .copyWith(
  //         id: id,
  //         createTime: time.toMyDateTime,
  //       )
  //       .toMap());
  //   sendChat(MessageModel(
  //     type: "sendgift",
  //     message: (gifChatModel.image == "2.gif")
  //         ? "${gifChatModel.createUserName} has lit fireworks"
  //         : "${gifChatModel.createUserName} has shot fireworks",
  //     createUserId: "${gifChatModel.createUserId}",
  //     createUserName: gifChatModel.createUserName,
  //   ));
  // }

  Future<List<String>> getListBlackWork() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection("setting")
          .doc("blackword")
          .get();
      var data = result.data();
      List<String> listBlackWord = [];
      for (var element in data?['data']) {
        listBlackWord.add(element.toString().toUpperCase());
      }
      return listBlackWord;
    } catch (e) {
      print("Loi: $e");
      return [];
    }
  }

  Future<List<String>> getListBlock(String userID) async {
    List<String> listData = [];
    try {
      var result = await FirebaseFirestore.instance
          .collection("block")
          .doc(userID)
          .get();
      if (result.data() != null && result.data()!.containsKey("data")) {
        for (var element in result.data()?['data']) {
          listData.add(element.toString());
        }
      }
      return listData;
    } catch (e) {
      print("Error: $e");
      return listData;
    }
  }

  Future<void> addListBloc(
      {required String userId, required List<String> data}) async {
    await FirebaseFirestore.instance
        .collection("block")
        .doc(userId)
        .set({"data": data});
  }
}

extension DateTimeExtension on DateTime {
  String get toMyDateTime {
    String formattedDate = DateFormat('yyyy/MM/dd HH:mm:ss').format(this);
    return formattedDate;
  }
}

extension DateTimeFromExtension on String {
  String get toMyDateTime {
    var formattedDateFrom = DateFormat('yyyy-MM-ddTHH:mm:sssZ').parse(this);
    String formattedDate =
        DateFormat('yyyy/MM/dd HH:mm:ss').format(formattedDateFrom);
    return formattedDate;
  }
}
