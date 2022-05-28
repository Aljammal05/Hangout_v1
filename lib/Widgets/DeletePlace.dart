import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class DeletePlace extends StatelessWidget {
  const DeletePlace({Key? key, required this.currentPlaceId}) : super(key: key);
  final String currentPlaceId;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
                'Delete',
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