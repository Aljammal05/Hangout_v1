import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v1/Owner/AddPlace.dart';
import 'package:flutter_v1/User/DashboardPage.dart';
import 'package:flutter_v1/Dialogs/Dialogs.dart';
import 'package:flutter_v1/EditEmailPage.dart';
import 'package:flutter_v1/Services/AuthServices.dart';
import 'package:flutter_v1/Services/StorageService.dart';
import 'package:flutter_v1/SignInPage.dart';
import 'dart:io';

import 'package:flutter_v1/constants/constants.dart';
import 'package:flutter_v1/models/PlaceModel.dart';
import 'package:flutter_v1/models/UserModel.dart';
import 'package:image_picker/image_picker.dart';

import 'Owner/EditPlace.dart';
import 'Owner/PlaceMainPage.dart';
import 'Templates/ProfilePageTemplate.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  List<RecentWidget> _ownedPlaces = [], _favoritePlaces = [];

  void fillOwnedPlaces() async {
    _ownedPlaces = [];
    List ownedPlacesIds = AuthServices.signedInUser.ownedPlacesIds;
    for (var element in ownedPlacesIds) {
      _ownedPlaces.add(
        RecentWidget(
          currentPlaceID: element,
        ),
      );
    }
  }

  void fillFavoritePlaces() async {
    _favoritePlaces = [];
    List favoritePlacesIds = AuthServices.signedInUser.favoritePlacesIds;
    for (var element in favoritePlacesIds) {
      _favoritePlaces.add(
        RecentWidget(currentPlaceID: element),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fillOwnedPlaces();
    fillFavoritePlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x00ffffff),
      body: ProfilePageTemplate(
        image: AuthServices.signedInUser.profilePicURL.isNotEmpty
            ? NetworkImage(AuthServices.signedInUser.profilePicURL)
            : const AssetImage('image/profile-default-pic.jpg')
                as ImageProvider,
        topChild: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                    onTap: () {
                      setState(
                        () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 105,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () async {
                        final PickedFile? image = await ImagePicker()
                            .getImage(source: ImageSource.camera);
                        File img = File(image!.path);
                        String url = await StorageService.uploadProfilePicture(
                            AuthServices.signedInUser.profilePicURL, img);
                        setState(
                          () {
                            usersReference
                                .doc(AuthServices.signedInUser.id)
                                .update({'ProfilePicURL': url});
                            AuthServices.signedInUser.profilePicURL = url;
                          },
                        );
                      },
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        AuthServices.signedInUser.name,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      Text(
                        AuthServices.signedInUser.city,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      final PickedFile? image = await ImagePicker()
                          .getImage(source: ImageSource.gallery);
                      File img = File(image!.path);
                      String url = await StorageService.uploadProfilePicture(
                          AuthServices.signedInUser.profilePicURL, img);
                      setState(
                        () {
                          usersReference
                              .doc(AuthServices.signedInUser.id)
                              .update({'ProfilePicURL': url});
                          AuthServices.signedInUser.profilePicURL = url;
                        },
                      );
                    },
                    child: const Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        bottomChild: Padding(
          padding: const EdgeInsets.only(top: 20.0, right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                ' Email Address',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(
                height: 15,
                child: Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 12),
                    child: Text(
                      ' ' + AuthServices.signedInUser.email,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SafeArea(
                                  child: EditEmailPage(
                                      email: AuthServices.signedInUser.email),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: const Icon(
                      Icons.edit,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                ' Phone NO.',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(
                height: 15,
                child: Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12),
                child: Text(
                  ' ' + AuthServices.signedInUser.phoneNO,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              AuthServices.signedInUser.userType == 'user'
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          ' Favorite',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 15,
                          child: Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const SafeArea(
                                              child: DashboardPage(),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 125,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                      color: Color(0x66ffffff),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: _favoritePlaces.reversed.toList(),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  : AuthServices.signedInUser.userType == 'owner'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              ' Owned Places',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 15,
                              child: Divider(
                                color: Colors.white,
                                thickness: 1,
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 125,
                                        width: 100,
                                        decoration: const BoxDecoration(
                                          color: Color(0x66ffffff),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: _ownedPlaces.reversed.toList(),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      : Container(),
              Padding(
                padding: const EdgeInsets.only(top: 30, right: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => WarningDialog(
                            title: 'Delete Account',
                            text:
                                'Are you sure you want to delete your\naccount? This will permnently erase\nyour account.',
                            buttonTittle: 'Delete',
                            onAccept: () async {
                              try {
                                final user = FirebaseAuth.instance.currentUser;
                                if (AuthServices.signedInUser.userType ==
                                    'owner') {
                                  List ownedPlacesIds = await usersReference
                                      .doc(AuthServices.signedInUser.id)
                                      .get()
                                      .then((value) =>
                                          value.data()!['ownedplaces']);
                                  for (var place in ownedPlacesIds) {
                                    placesReference.doc(place).delete();
                                  }
                                }
                                await user!.delete();
                                await usersReference
                                    .doc(AuthServices.signedInUser.id)
                                    .delete();
                                AuthServices.signedInUser = UserModel();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const SafeArea(
                                          child: SignInPage());
                                    },
                                  ),
                                );
                              } catch (e) {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => ErrorDialog(
                                    title: 'ERROR',
                                    text: e.toString(),
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'Delete Account',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const Icon(Icons.delete, size: 25, color: Colors.white)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class RecentWidget extends StatefulWidget {
  const RecentWidget({Key? key, this.currentPlaceID = ''}) : super(key: key);

  final String currentPlaceID;

  @override
  _RecentWidgetState createState() => _RecentWidgetState();
}

class _RecentWidgetState extends State<RecentWidget> {
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
        PlaceModel placeModel;
        try {
          placeModel = PlaceModel.fromDoc(snapshot.data);
          return GestureDetector(
            onTap: () async {
              String _usertype = AuthServices.signedInUser.userType;
              setState(
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SafeArea(
                          child: _usertype == 'user'
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 125,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  image: DecorationImage(
                      image: NetworkImage(placeModel.placePicURl),
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.80), BlendMode.dstATop),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          );
        } catch (e) {
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (context) => ErrorDialog(
              title: 'ERROR',
              text: e.toString(),
            ),
          );
          return Container();
        }
      },
    );
  }
}
