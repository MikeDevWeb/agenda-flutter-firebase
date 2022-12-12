import 'package:cloud_firestore/cloud_firestore.dart';

class Agenda {
  int id;
  DateTime time;
  // DateTime created = DateTime.now();
  String title;
  String content;
  String image;

  Agenda(
      {this.id = 0,
      required this.time,
      this.title = "",
      this.content = "",
      this.image = ""});
}
