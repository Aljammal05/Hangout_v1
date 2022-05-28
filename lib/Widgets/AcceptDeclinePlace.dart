import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class AcceptDeclinePlace extends StatelessWidget {
  const AcceptDeclinePlace({Key? key, required this.currentPlaceId})
      : super(key: key);
  final String currentPlaceId;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: TextButton(
              child: const Text(
                'Accept',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () {
                placesReference.doc(currentPlaceId).update({'status': 'accepted'});
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
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: TextButton(
              child: const Text(
                'Decline',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () async {
                usersReference
                    .doc(
                  await placesReference.doc(currentPlaceId).get().then(
                        (value) {
                      return value.data()!['ownerID'];
                    },
                  ),
                )
                    .update(
                  {
                    'ownedplaces': FieldValue.arrayRemove([currentPlaceId])
                  },
                );
                placesReference.doc(currentPlaceId).delete();
              },
            ),
          ),
        ),
      ],
    );
  }
}