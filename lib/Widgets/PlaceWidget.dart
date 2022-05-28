import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Models/PlaceModel.dart';
import '../Owner/EditPlace.dart';
import '../Owner/PlaceMainPage.dart';
import '../Services/AuthServices.dart';
import '../constants/constants.dart';

class PlaceWidget extends StatefulWidget {
  const PlaceWidget({Key? key, this.currentPlaceID = '', this.height = 190})
      : super(key: key);
  final String currentPlaceID;
  final double height;

  @override
  _PlaceWidgetState createState() => _PlaceWidgetState();
}

class _PlaceWidgetState extends State<PlaceWidget> {
  bool isFavorite() {
    for (var placeId in AuthServices.signedInUser.favoritePlacesIds) {
      if (placeId == widget.currentPlaceID) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: placesReference.doc(widget.currentPlaceID).get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }
        try {
          PlaceModel placeModel = PlaceModel.fromDoc(snapshot.data);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SafeArea(
                            child: AuthServices.signedInUser.userType == 'user'
                                ? PlaceMainPage(
                              currentPlaceID: widget.currentPlaceID,
                            )
                                : EditPlace(
                              placeModel.costPerPerson,
                              currentPlaceID: widget.currentPlaceID,
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(placeModel.placePicURl),
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.85), BlendMode.dstATop),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AuthServices.signedInUser.userType == 'user'
                              ? GestureDetector(
                            onTap: () {
                              setState(
                                    () {
                                  if (isFavorite()) {
                                    usersReference
                                        .doc(AuthServices.signedInUser.id)
                                        .update(
                                      {
                                        'favoriteplaces':
                                        FieldValue.arrayRemove(
                                            [widget.currentPlaceID])
                                      },
                                    );
                                    AuthServices
                                        .signedInUser.favoritePlacesIds
                                        .remove(widget.currentPlaceID);
                                  } else {
                                    usersReference
                                        .doc(AuthServices.signedInUser.id)
                                        .update(
                                      {
                                        'favoriteplaces':
                                        FieldValue.arrayUnion(
                                            [widget.currentPlaceID])
                                      },
                                    );
                                    AuthServices
                                        .signedInUser.favoritePlacesIds
                                        .add(widget.currentPlaceID);
                                  }
                                },
                              );
                            },
                            child: Icon(
                              isFavorite()
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.white,
                              size: 27,
                            ),
                          )
                              : Container()
                        ],
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              placeModel.name,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  placeModel.city + ' , ' + placeModel.area,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } catch (e) {
          return Container();
        }
      },
    );
  }
}