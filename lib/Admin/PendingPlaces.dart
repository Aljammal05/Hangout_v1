import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v1/constants/constants.dart';

import '../Widgets/AcceptDeclinePlace.dart';
import '../Widgets/AdminPlaceWidget.dart';

class PendingPlaces extends StatefulWidget {
  const PendingPlaces({Key? key}) : super(key: key);

  @override
  _PendingPlacesState createState() => _PendingPlacesState();
}

class _PendingPlacesState extends State<PendingPlaces> {
  List<AdminPlaceWidget> _pending = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: placesReference.where('status', isEqualTo: 'pending').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }
        _pending = [];
        for (var place in snapshot.data!.docs) {
          _pending.add(
            AdminPlaceWidget(
              currentPlaceId: place.id,
              child: AcceptDeclinePlace(
                currentPlaceId: place.id,
              ),
            ),
          );
        }
        return Container(
          decoration: const BoxDecoration(
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
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: linearGradiantColorsHalfOpacity, // red to yellow
                        tileMode: TileMode.repeated,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      child: SingleChildScrollView(
                        child: Column(
                          children: _pending,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
