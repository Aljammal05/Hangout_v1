import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v1/constants/constants.dart';

import '../Widgets/AdminPlaceWidget.dart';
import '../Widgets/DeletePlace.dart';

class AcceptedPlaces extends StatefulWidget {
  const AcceptedPlaces({Key? key}) : super(key: key);

  @override
  _AcceptedPlacesState createState() => _AcceptedPlacesState();
}

class _AcceptedPlacesState extends State<AcceptedPlaces> {
  List<AdminPlaceWidget> _accepted = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: placesReference.where('status', isEqualTo: 'accepted').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }
        _accepted = [];
        for (var place in snapshot.data!.docs) {
          _accepted.add(
            AdminPlaceWidget(
              currentPlaceId: place.id,
              child: DeletePlace(currentPlaceId: place.id),
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
                          children: _accepted,
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
