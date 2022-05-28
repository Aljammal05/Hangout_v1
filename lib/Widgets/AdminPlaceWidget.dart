import 'package:flutter/material.dart';

import '../Admin/AdminShowPlace.dart';
import '../models/PlaceModel.dart';
import '../constants/constants.dart';

class AdminPlaceWidget extends StatelessWidget {
  const AdminPlaceWidget(
      {Key? key, this.currentPlaceId = '', required this.child})
      : super(key: key);
  final String currentPlaceId;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: placesReference.doc(currentPlaceId).get(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }
        PlaceModel placeModel = PlaceModel.fromDoc(snapshot.data);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SafeArea(
                      child: AdminShowPlace(
                          placeModel: placeModel,
                          currentPlaceID: currentPlaceId),
                    );
                  },
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(placeModel.placePicURl),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.85), BlendMode.dstATop),
                    ),
                    color: const Color(0x99ffffff),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              placeModel.name,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 23),
                            ),
                            Text(
                              placeModel.city + ',' + placeModel.area,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: child,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}