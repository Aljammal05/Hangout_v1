import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v1/Admin/AdminShowPlace.dart';
import 'package:flutter_v1/constants/constants.dart';
import 'package:flutter_v1/models/PlaceModel.dart';
class AdminPlaceWidget extends StatelessWidget {
  const AdminPlaceWidget({Key? key, this.currentplaceid = '', required this.child}) : super(key: key);
  final String currentplaceid;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: placesref.doc(currentplaceid).get(),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SafeArea(
                    child: AdminShowPlace(
                        placeModel: placeModel,
                        currentplaceID:  currentplaceid));
              }));
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
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              placeModel.name,
                              style:
                              const TextStyle(color: Colors.white, fontSize: 23),
                            ),
                            Text(
                              placeModel.city + ',' + placeModel.area,
                              style:
                              const TextStyle(color: Colors.white, fontSize: 18),
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

class AcceptDeclinePlace extends StatelessWidget {
  const AcceptDeclinePlace({Key? key, required this.currentplaceid}) : super(key: key);
  final String currentplaceid;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: TextButton(
              child: const Text(
                'Accept',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () {
                placesref.doc(currentplaceid).update({'status': 'accepted'});
              },
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            height: 50,
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: TextButton(
              child: const Text(
                'Decline',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed:  () async {
                usersref
                    .doc(
                    await placesref.doc(currentplaceid).get().then((value) {
                      return value.data()!['ownerID'];
                    }))
                    .update({
                  'ownedplaces': FieldValue.arrayRemove([currentplaceid])
                });
                placesref.doc(currentplaceid).delete();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class DeletePlace extends StatelessWidget {
  const DeletePlace({Key? key, required this.currentplaceid}) : super(key: key);
  final String currentplaceid;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () async {
                usersref
                    .doc(
                    await placesref.doc(currentplaceid).get().then((value) {
                      return value.data()!['ownerID'];
                    }))
                    .update({
                  'ownedplaces': FieldValue.arrayRemove([currentplaceid])
                });
                placesref.doc(currentplaceid).delete();
              },
            ),
          ),
        ),
      ],
    );
  }
}
