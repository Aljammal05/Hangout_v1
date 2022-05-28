import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

final usersref = _firestore.collection('users');
final placesref = _firestore.collection('places');
final feedbackref= _firestore.collection('feedback');