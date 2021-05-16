import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stack_finance_assignment/base_state.dart';
import 'package:stack_finance_assignment/model/notes.dart';
import 'package:stack_finance_assignment/util/color/colors.dart';
import 'package:stack_finance_assignment/util/enum.dart';
import 'package:stack_finance_assignment/util/helper.dart';

class NotesProvider extends BaseState {
  Map<String, dynamic> data;

  NotesProvider(this.data) {
    notesType = data['type'];
    notes = data['notes'];

    if (notesType != NotesType.NewNote) {
      noteTitleController.text = notes.title;
      noteDescriptionController.text = notes.desc;
      if (notesType == NotesType.EditNote) {
        title = 'Edit Note';
      } else
        title = 'Note';
    } else {
      title = 'New Note';
    }
  }

  String title = '';

  NotesType notesType;
  Notes notes;

  /// title text controller
  TextEditingController noteTitleController = TextEditingController();

  /// title text controller
  TextEditingController noteDescriptionController = TextEditingController();

  /// title focus Node
  FocusNode noteTitleNode = FocusNode();

  /// description focus Node
  FocusNode noteDescriptionNode = FocusNode();

  final ImagePicker _picker = ImagePicker();

  String imagePath;

  void addNewNote(DocumentReference docReference, {imageUrl}) {
    Map<String, dynamic> data = {
      'id': docReference.id,
      'title': noteTitleController.text,
      'desc': noteDescriptionController.text
    };
    if (imageUrl != null) {
      data['imageUrl'] = imageUrl;
    }
    docReference.set(data).then((result) {
      updateProgressIndicatorStatus(false);
      Fluttertoast.showToast(
          msg: "Note add successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: primaryColor,
          fontSize: 16.0);
      Navigator.pop(scaffoldKey.currentContext);
    }).catchError((error) {
      updateErrorWidget('error');
      updateProgressIndicatorStatus(false);
    });
  }

  void updateNote(DocumentReference docReference) {
    notes.title = noteTitleController.text;
    notes.desc = noteDescriptionController.text;
    docReference.set(notes.toJson()).then((result) {
      updateProgressIndicatorStatus(false);
      Fluttertoast.showToast(
          msg: "Note updated successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: primaryColor,
          fontSize: 16.0);
      Navigator.pop(scaffoldKey.currentContext);
    }).catchError((error) {
      updateErrorWidget('error');
      updateProgressIndicatorStatus(false);
    });
  }

  void onClickOfSave() {
    dismissErrorWidget();
    dismissKeyboard(scaffoldKey.currentContext);
    if (formKey.currentState.validate()) {
      updateProgressIndicatorStatus(true);
      if (notesType == NotesType.NewNote) {
        if (imagePath.isNotEmpty) {
          imageUpload();
        } else {
          addNewNote(FirebaseFirestore.instance
              .collection("notes")
              .doc(FirebaseAuth.instance.currentUser.uid)
              .collection("notes")
              .doc());
        }
      } else {
        updateNote(FirebaseFirestore.instance
            .collection("notes")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection("notes")
            .doc(notes.id));
      }
    }
  }

  void imageUpload() {
    FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}')
        .putFile(File(imagePath))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        ;
        addNewNote(
            FirebaseFirestore.instance
                .collection("notes")
                .doc(FirebaseAuth.instance.currentUser.uid)
                .collection("notes")
                .doc(),
            imageUrl: value);
      });
    });
  }

  void onClickOfAddImage() {
    _picker.getImage(source: ImageSource.gallery).then((value) {
      imagePath = value.path;
      notifyListeners();
    });
  }

  void onCancelOfImage() {
    imagePath = '';
    notifyListeners();
  }
}
