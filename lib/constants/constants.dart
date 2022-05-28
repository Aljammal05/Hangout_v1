import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

final usersReference = _firestore.collection('users');
final placesReference = _firestore.collection('places');

const linearGradiantColors = [
  Color(0xff056CB9),
  Color(0xff7189C3)
];

const secondaryColor = Color(0xff7189C3);

const linearGradiantColorsHalfOpacity = [
  Color(0xb8056CB9),
  Color(0xb87189C3)
];

const secondaryColorHalfOpacity = Color(0xb87189C3);