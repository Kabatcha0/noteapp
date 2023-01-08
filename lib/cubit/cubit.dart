import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:noteapp/components/components.dart';
import 'package:noteapp/network/const.dart';
import 'package:noteapp/network/local.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:noteapp/cubit/states.dart';

class NoteCubit extends Cubit<NoteStates> {
  NoteCubit() : super(NoteInitialState());
  static NoteCubit get(context) => BlocProvider.of(context);

  void authCreate(
      {required String email,
      required String password,
      required String gender,
      required BuildContext context,
      required String name,
      required Widget widget}) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email.trim(), password: password)
        .then((value) {
      uid = value.user!.uid;

      firebaseStore(
          user: name, uiD: uid!, gender: gender, pass: password, email: email);

      navigator(context: context, widget: widget);
    }).catchError((e) {
      print(e.toString());
    });
  }

  List? data;
  List id = [];
  void getData() {
    data = [];
    id = [];
    getTheData = true;

    FirebaseFirestore.instance
        .collection("notes")
        .orderBy("date", descending: true)
        .where("uid", isEqualTo: uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        id.add(element.id);
      });
      value.docs.forEach((element) {
        data!.add(element.data());
      });

      emit(NoteGetDataState());
    }).catchError((e) {
      print(e.toString());
    });
  }

  void authSignIn({
    required String email,
    required String password,
    required BuildContext context,
    required Widget widget,
  }) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.trim(), password: password)
        .then((value) {
      uid = value.user!.uid;
      CacheHelper.setString("uid", value.user!.uid);

      emit(NoteSignInAuthState());
      navigator(context: context, widget: widget);
    }).catchError((e) {
      print(e.toString());
    });
  }

  void firebaseStore({
    required String user,
    required String uiD,
    required String gender,
    required String pass,
    required String email,
  }) {
    FirebaseFirestore.instance.collection("users").doc(uiD).set({
      "user": user,
      "uid": uiD,
      "gender": gender,
      "pass": pass,
      "email": email,
    }).then((value) {
      CacheHelper.setString("uid", uiD);
      print(uiD);
      print("================================================");
      emit(NoteFireStoreState());
    }).catchError((e) {
      print("moaohme${e.toString()}");
    });
  }

  String? imageUrl;
  void addNotes(
      {required String title,
      required String body,
      required DateTime date}) async {
    emit(NoteAddNotesLoadingState());
    random = Random().nextInt(100);
    addImageNotes(path: file != null ? "${random}${basename(file!.path)}" : "");
    if (file != null) {
      await ref!.putFile(file!);
      imageUrl = await ref!.getDownloadURL();
    }
    FirebaseFirestore.instance.collection("notes").add({
      "title": title,
      "body": body,
      "image": file != null ? imageUrl : "",
      "date": date,
      "uid": uid
    }).then((value) {
      getData();
    }).catchError((e) {
      print(e.toString());
    });
  }

  File? file;
  ImagePicker? imagePicker;
  var random;

  void imagePick({required BuildContext context}) {
    imagePicker = ImagePicker();
    imagePicker!.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        file = File(value.path);

        emit(NoteImagePickerState());
      } else {
        return null;
      }
    });
  }

  Reference? ref;
  void addImageNotes({required String path}) async {
    ref = FirebaseStorage.instance.ref("image").child(path);
  }

  void update(
      {required String title, required String body, required String doc}) {
    emit(NoteUpdateNotesLoadingState());
    FirebaseFirestore.instance
        .collection("notes")
        .doc(doc)
        .update({"title": title, "body": body}).then((value) {
      getData();
      emit(NoteUpdateNotesState());
    }).catchError((e) {});
  }

  void deleteNote(
      {required String doc, required int index, required List dataRemove}) {
    print("================================");
    print(data);
    FirebaseFirestore.instance
        .collection("notes")
        .doc(doc)
        .delete()
        .then((value) {
      if (dataRemove[index]["image"] != "") {
        FirebaseStorage.instance
            .refFromURL(dataRemove[index]["image"])
            .delete()
            .then((v) {});
      }
      getData();
      print("================data================");
      print(data);
      emit(DeleteNoteState());
    }).catchError((e) {});
  }
}
