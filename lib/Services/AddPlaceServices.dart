import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_v1/constants/constants.dart';

class AddPlaceServices {
  static Future<bool> addPlace(
      String userID,
      double costPerPerson,
      String name,
      String description,
      String city,
      String area,
      String phoneNo,
      String websiteURL,
      String placePicURL,
      String category,
      ) async {
    try {
      placesref.doc(name + '-' + area).set({
        'ownerID':userID,
        'name': name,
        'description': description,
        'category': category,
        'cost per person':costPerPerson,
        'city': city,
        'area': area,
        'phoneNo': phoneNo,
        'websiteURL': websiteURL,
        'placepicURL': placePicURL,
        'status' : 'pending'
      });
      usersref.doc(userID).update({
        'ownedplaces':FieldValue.arrayUnion([name+'-'+area])
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
