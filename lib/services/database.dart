import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harang/models/lecture.dart';
import 'package:harang/models/ranking.dart';
import 'package:harang/models/user.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
        "score": user.score,
        "stageProgress": user.stageProgress,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String? uid) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection("users").doc(uid).get();
      return UserModel?.fromDocumentSnapshot(documentSnapshot: _doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  //Android 10 버전에서 Accessing hidden method 메세지가 출력되지만, 이는 앱이 아닌 Android Protobuf 관련 문제로 Android 11에 해결됨. | 참조: https://github.com/flutter/flutter/issues/27095#issuecomment-722857855
  Future<LectureContent> getLectureContent(int chapterNum) async {
    try {
      DocumentSnapshot _doc = await _firestore.collection("lectures").doc("chapter$chapterNum").get();
      return LectureContent?.fromDocumentSnapshot(documentSnapshot: _doc, chapterNum: chapterNum);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> unlockNextStage(Map stageProgress) async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;

      await _firestore.collection("users").doc(uid).update({
        "stageProgress": stageProgress,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> plusUserPoint(int plusPoint) async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      UserModel _user = await Database().getUser(uid);

      await _firestore.collection("users").doc(uid).update({
        "score": _user.score! + plusPoint,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<RankingModel>> getRanking() async {
    List<RankingModel> _ranking = List.empty(growable: true);
    try {
      await _firestore.collection("users").orderBy("score", descending: true).get().then((value){
        value.docs.forEach((element) {
          _ranking.add(RankingModel.fromDocumentSnapshot(documentSnapshot: element));
        });
      });
      return _ranking;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
