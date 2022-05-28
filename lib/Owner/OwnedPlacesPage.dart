import 'package:flutter/material.dart';
import 'package:flutter_v1/Owner/AddPlace.dart';
import 'package:flutter_v1/Services/AuthServices.dart';
import 'package:flutter_v1/constants/constants.dart';

import '../Templates/DashboardTemplate.dart';
import '../Widgets/PlaceWidget.dart';

class OwnedPlacesPage extends StatefulWidget {
  const OwnedPlacesPage({Key? key}) : super(key: key);

  @override
  _OwnedPlacesPageState createState() => _OwnedPlacesPageState();
}

class _OwnedPlacesPageState extends State<OwnedPlacesPage> {
  List<PlaceWidget> owned1 = [];
  List<PlaceWidget> owned2 = [];

  void fillOwnedPlaces() async {
    List _ownedPlacesIds = AuthServices.signedInUser.ownedPlacesIds;
    owned1 = [];
    owned2 = [];
    for (var place in _ownedPlacesIds.reversed) {
      setState(
        () {
          if (owned1.length <= owned2.length) {
            if (owned1.length % 2 == 0) {
              owned1.add(PlaceWidget(
                currentPlaceID: place,
                height: 230,
              ));
            } else {
              owned1.add(PlaceWidget(currentPlaceID: place));
            }
          } else {
            if (owned2.length % 2 == 1) {
              owned2.add(
                PlaceWidget(
                  currentPlaceID: place,
                  height: 230,
                ),
              );
            } else {
              owned2.add(PlaceWidget(currentPlaceID: place));
            }
          }
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fillOwnedPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DashboardTemplate(
          pageTittle: 'Owned Places',
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(children: owned1),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(children: owned2),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: 15,
          bottom: 15,
          child: FloatingActionButton(
            backgroundColor: secondaryColor,
            onPressed: () {
              setState(
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const SafeArea(
                          child: AddPlace(),
                        );
                      },
                    ),
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        )
      ],
    );
  }
}
