import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  void addNewNote(DocumentReference docReference) {
    docReference.set({
      'id': docReference.id,
      'title': noteTitleController.text,
      'desc': noteDescriptionController.text
    }).then((result) {
      debugPrint('result --- ');
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
    docReference.set({
      'id': notes.id,
      'title': noteTitleController.text,
      'desc': noteDescriptionController.text
    }).then((result) {
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
        addNewNote(FirebaseFirestore.instance
            .collection("notes")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection("notes")
            .doc());
      } else {
        updateNote(FirebaseFirestore.instance
            .collection("notes")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection("notes")
            .doc(notes.id));
      }
    }

    void onClickOfAddImage() {}
  }
}
