import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id, name, email, password, phoneNO, city, userType, profilePicURL;
  List ownedPlacesIds = [], recentlyVisitedIds = [], favoritePlacesIds = [];
  UserModel({
    this.id = '',
    this.name = '',
    this.email = '',
    this.password = '',
    this.phoneNO = '',
    this.city = '',
    this.userType = '',
    this.profilePicURL = '',
    this.ownedPlacesIds = const [],
    this.recentlyVisitedIds = const [],
    this.favoritePlacesIds = const [],
  });
  factory UserModel.fromDoc(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      userType: doc['userType'],
      name: doc['name'],
      email: doc['email'],
      password: doc['password'],
      phoneNO: doc['phoneNo'],
      city: doc['city'],
      profilePicURL: doc['ProfilePicURL'],
      ownedPlacesIds: doc['ownedplaces'],
      recentlyVisitedIds: doc['recentlyvisited'],
      favoritePlacesIds: doc['favoriteplaces'],
    );
  }
}
