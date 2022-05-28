import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceModel {
  String id,
      ownerID,
      name,
      description,
      category,
      city,
      area,
      phoneNo,
      websiteURL,
      placePicURl,
      status;
  double costPerPerson;
  PlaceModel({
    this.id = '',
    this.ownerID = '',
    this.name = '',
    this.description = '',
    this.category = '',
    this.costPerPerson=0,
    this.city = '',
    this.area = '',
    this.phoneNo = '',
    this.websiteURL = '',
    this.placePicURl = '',
    this.status='pending',
  });
  factory PlaceModel.fromDoc(DocumentSnapshot doc) {
    return PlaceModel(
      id: doc.id,
      ownerID: doc['ownerID'],
      name: doc['name'],
      description: doc['description'],
      category: doc['category'],
      costPerPerson: doc['cost per person'],
      city: doc['city'],
      area: doc['area'],
      phoneNo: doc['phoneNo'],
      websiteURL: doc['websiteURL'],
      placePicURl: doc['placepicURL'],
      status: doc['status'],
    );
  }
}
