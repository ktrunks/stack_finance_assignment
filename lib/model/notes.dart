import 'package:flutter/material.dart';

class Notes {
  String id;
  String title;
  String desc;
  String imageUrl;

  Notes({
    @required this.id,
    @required this.title,
    @required this.desc,
    @required this.imageUrl,
  });

  Notes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['imageUrl'] = this.imageUrl;

    return data;
  }
}
