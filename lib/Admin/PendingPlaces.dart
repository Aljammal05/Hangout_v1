import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v1/Widgets/Widgets.dart';
import 'package:flutter_v1/constants/constants.dart';

class PendingPlaces extends StatefulWidget {
  _PendingPlacesState createState() => _PendingPlacesState();
}

class _PendingPlacesState extends State<PendingPlaces> {
  List<AdminPlaceWidget> _pending = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: placesref.where('status', isEqualTo: 'pending').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            );
          }
          _pending = [];
          snapshot.data!.docs.forEach((place) {
            _pending.add(AdminPlaceWidget(
              currentplaceid: place.id,
              child: AcceptDeclinePlace(currentplaceid: place.id,),
            ));
          });
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('image/deadsea.jpg'), fit: BoxFit.cover),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: <Color>[
                              Color(0x77ffffff),
                              Color(0xb80C89C3)
                            ], // red to yellow
                            tileMode: TileMode.repeated,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        child: SingleChildScrollView(
                            child: Column(
                              children: _pending,
                            )),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}