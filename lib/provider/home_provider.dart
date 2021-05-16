import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stack_finance_assignment/model/notes.dart';
import 'package:stack_finance_assignment/routes/sf_routes.dart';
import 'package:stack_finance_assignment/util/enum.dart';

import '../base_state.dart';

class HomeProvider extends BaseState {
  HomeProvider() {
    getNotes();
  }

  NetWorkResponseStatus responseStatus = NetWorkResponseStatus.Loading;
  List<Notes> notes = [];
  String responseError;

  /// user logout
  void onClickOfSignOut() async {
    if (FirebaseAuth.instance.currentUser.providerData
            .elementAt(0)
            .providerId ==
        'google.com') {
      GoogleSignIn().signOut();
    }
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pop(scaffoldKey.currentContext);
      Navigator.popAndPushNamed(scaffoldKey.currentContext, SFRoutes.root);
    });
  }

  void onClickOfAddNote() {
    Map<String, dynamic> notesData = {};
    notesData['type'] = NotesType.NewNote;
    Navigator.pushNamed(scaffoldKey.currentContext, SFRoutes.addNote,
        arguments: notesData);
  }

  void getNotes() {
    FirebaseFirestore.instance
        .collection("notes")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("notes")
        .snapshots()
        .listen((querySnapshot) {

      if (notes.length > 0) {
        notes.clear();
      }
      if (querySnapshot.size > 0) {
        querySnapshot.docs.forEach((query) {
          notes.add(Notes.fromJson(query.data()));
          responseStatus = NetWorkResponseStatus.ResponseData;
          notifyListeners();
        });
      } else {
        responseStatus = NetWorkResponseStatus.ResponseEmpty;
        notifyListeners();
      }
    });
  }

  void onClickOfDelete(Object note, Object p2) {
    Notes notes = note;
    FirebaseFirestore.instance
        .collection("notes")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("notes")
        .doc(notes.id)
        .delete();
  }

  void onClickOfChangePassword() {
    Navigator.pop(scaffoldKey.currentContext);
    Navigator.pushNamed(scaffoldKey.currentContext, SFRoutes.changePassword);
  }
}
