import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v1/Dialogs/Dialogs.dart';
import 'package:flutter_v1/Services/AuthServices.dart';
import 'package:flutter_v1/Services/StorageService.dart';
import 'dart:io';
import 'package:flutter_v1/constants/constants.dart';
import 'package:flutter_v1/models/PlaceModel.dart';
import 'package:image_picker/image_picker.dart';

import '../Templates/ProfilePageTemplate.dart';
import '../Widgets/LinearColoredButton.dart';
import 'OwnedPlacesPage.dart';


class EditPlace extends StatefulWidget {
   EditPlace(this.costPerPerson,
      {required this.currentPlaceID, Key? key} )
      : super(key: key);
  final String currentPlaceID;
  double costPerPerson;

  @override
  _EditPlaceState createState() => _EditPlaceState();
}

class _EditPlaceState extends State<EditPlace> {
  String? _description = '', _phoneNo = '', _websiteURL = '';
  String _placePicURL = '';
  File? _img;

  getPlace() async {
    var place = await placesReference.doc(widget.currentPlaceID).get();
    _placePicURL = place.data()!['placepicURL'];
  }

  displayImage() {
    if (_img == null) {
      return NetworkImage(_placePicURL);
    } else {
      return FileImage(_img!);
    }
  }

  @override
  initState() {
    super.initState();
    getPlace();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: placesReference.doc(widget.currentPlaceID).get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }
        PlaceModel placeModel = PlaceModel.fromDoc(snapshot.data);
        return ProfilePageTemplate(
          image: displayImage(),
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
                    GestureDetector(
                      onTap: () {
                        try {
                          placesReference.doc(widget.currentPlaceID).delete();
                          usersReference.doc(AuthServices.signedInUser.id).update(
                            {
                              'ownedplaces': FieldValue.arrayRemove(
                                  [widget.currentPlaceID])
                            },
                          );
                          setState(
                            () {
                              AuthServices.signedInUser.ownedPlacesIds
                                  .remove(widget.currentPlaceID);
                            },
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const SafeArea(
                                  child: OwnedPlacesPage(),
                                );
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
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 27,
                      ),
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
                          final PickedFile? pickedImage = await ImagePicker()
                              .getImage(source: ImageSource.camera);

                          setState(
                            () {
                              _img = File(pickedImage!.path);
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
                    GestureDetector(
                      onTap: () async {
                        final PickedFile? pickedImage = await ImagePicker()
                            .getImage(source: ImageSource.gallery);
                        setState(
                          () {
                            _img = File(pickedImage!.path);
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  ' Information',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                const SizedBox(
                  height: 15,
                  child: Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5, left: 20),
                  child: Text(
                    ' Description',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    maxLength: 500,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      fillColor: const Color(0x33ffffff),
                      filled: true,
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide: BorderSide(
                          color: Color(0x66ffffff),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            color: Color(0x22ffffff), width: 3.0),
                      ),
                      hintText: placeModel.description,
                      hintStyle:
                          const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onChanged: (val) {
                      setState(
                        () {
                          _description = val;
                        },
                      );
                    },
                  ),
                ),
                const Text(
                  ' AVG Cost',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                const SizedBox(
                  height: 15,
                  child: Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.costPerPerson.round().toString(),
                        style:
                            const TextStyle(fontSize: 35, color: Colors.white),
                      ),
                      const Text(
                        ' JD',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Slider(
                  value: widget.costPerPerson,
                  min: 0,
                  max: 25,
                  divisions: 25,
                  activeColor: secondaryColor,
                  inactiveColor: const Color(0xffffffff),
                  onChanged: (newValue) {
                    setState(
                      () {
                        widget.costPerPerson = newValue;
                      },
                    );
                  },
                ),
                const Text(
                  ' Contact Us',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                const SizedBox(
                  height: 15,
                  child: Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      fillColor: const Color(0x33ffffff),
                      filled: true,
                      hintText: placeModel.phoneNo,
                      hintStyle:
                          const TextStyle(color: Colors.white, fontSize: 20),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(90),
                        ),
                        borderSide: BorderSide(
                          color: Color(0x66ffffff),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: const BorderSide(
                            color: Color(0x22ffffff), width: 3.0),
                      ),
                    ),
                    onChanged: (val) {
                      setState(
                        () {
                          _phoneNo = val;
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      fillColor: const Color(0x33ffffff),
                      filled: true,
                      hintText: placeModel.websiteURL,
                      hintStyle:
                          const TextStyle(color: Colors.white, fontSize: 20),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(90),
                        ),
                        borderSide: BorderSide(
                          color: Color(0x66ffffff),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: const BorderSide(
                            color: Color(0x22ffffff), width: 3.0),
                      ),
                    ),
                    onChanged: (val) {
                      setState(
                        () {
                          _websiteURL = val;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () async {
                      if (widget.costPerPerson == placeModel.costPerPerson&&
                          _phoneNo == '' &&
                          _websiteURL == '' &&
                          _description == '' &&
                          _img == null) {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const ErrorDialog(
                            title: 'Nothing\'s Changed',
                            text:
                                'You have not make any changes,\nno effect will applied.',
                          ),
                        );
                      } else {
                        if (_img != null) {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const WaitingDialog(),
                          );
                          _placePicURL =
                              await StorageService.uploadPlacePicture(
                                  _placePicURL, _img!);
                          placesReference.doc(widget.currentPlaceID).update(
                            {
                              'placepicURL': _placePicURL,
                            },
                          );
                          Navigator.pop(context);
                        }
                        setState(
                          () {
                            placesReference.doc(widget.currentPlaceID).update(
                              {
                                'description': _description == ''
                                    ? placeModel.description
                                    : _description,
                                'cost per person': widget.costPerPerson ==
                                        placeModel.costPerPerson
                                    ? placeModel.costPerPerson.round() / 1.0
                                    : widget.costPerPerson,
                                'phoneNo': _phoneNo == ''
                                    ? placeModel.phoneNo
                                    : _phoneNo,
                                'websiteURL': _websiteURL == ''
                                    ? placeModel.websiteURL
                                    : _websiteURL,
                              },
                            );
                            //todo update Auth.Signedin
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const SafeArea(
                                    child: OwnedPlacesPage(),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: const LinearColoredButton(
                      buttonTittle: 'SAVE',
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
