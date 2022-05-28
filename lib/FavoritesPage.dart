import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v1/Services/AuthServices.dart';
import 'package:flutter_v1/Templates/Templates.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<PlaceWidget> fav1 = [];
  List<PlaceWidget> fav2 = [];

  void fillFavoritePlaces() async {
    List favoritePlacesIds = AuthServices.signedInUser.favoritePlacesIds;
    fav1 = [];
    fav2 = [];
    for (var place in favoritePlacesIds.reversed) {
      setState(
        () {
          if (fav1.length <= fav2.length) {
            if (fav1.length % 2 == 0) {
              fav1.add(
                PlaceWidget(
                  currentPlaceID: place,
                  height: 230,
                ),
              );
            } else {
              fav1.add(
                PlaceWidget(currentPlaceID: place),
              );
            }
          } else {
            if (fav2.length % 2 == 1) {
              fav2.add(
                PlaceWidget(
                  currentPlaceID: place,
                  height: 230,
                ),
              );
            } else {
              fav2.add(
                PlaceWidget(currentPlaceID: place),
              );
            }
          }
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fillFavoritePlaces();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardTemplate(
      backgroundImagePath: 'image/petra.jpg',
      pageTittle: 'Favorites',
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
                  child: Column(
                    children: fav1,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: fav2,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
