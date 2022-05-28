import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v1/Dialogs/Dialogs.dart';
import 'package:flutter_v1/models/UserModel.dart';

class AuthServices {
  static final _auth = FirebaseAuth.instance;
  static UserModel signedInUser = UserModel() ;
  static final _firestore = FirebaseFirestore.instance;

  static Future<bool> signUp(String name, String email, String password,
      String phoneNO, String city, String userType, context) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? signedIn = authResult.user;
      if (signedIn != null) {
        _firestore.collection('users').doc(signedIn.uid).set({
          'name': name,
          'email': email,
          'password': password,
          'phoneNo': phoneNO,
          'city': city,
          'userType': userType,
          'ProfilePicURL': '',
          'recentlyvisited':[],
          'favoriteplaces':[],
          'ownedplaces':[]

        });
        return true;
      }
      return false;
    } catch (e) {
      Navigator.pop(context);
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (context) => ErrorDialog(title: 'ERROR',text: e.toString(),));
      return false;
    }
  }

  static Future<bool> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      signedInUser = UserModel.fromDoc(await _firestore.collection('users').doc(_auth.currentUser!.uid).get());
      return true;
    } catch (e) {
      return false;
    }
  }
}
