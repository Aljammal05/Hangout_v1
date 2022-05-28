import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_v1/Dialogs/Dialogs.dart';
import 'package:flutter_v1/OwnedPlacesPage.dart';
import 'package:flutter_v1/Services/AddPlaceServices.dart';
import 'package:flutter_v1/Services/AuthServices.dart';
import 'package:flutter_v1/Services/StorageService.dart';
import 'package:flutter_v1/Templates/Templates.dart';
import 'package:flutter_v1/lists/Lists.dart';
import 'package:image_picker/image_picker.dart';

class AddPlace extends StatefulWidget {
  const AddPlace({Key? key}) : super(key: key);

  @override
  _AddPlaceState createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  double _costPerPerson = 0;
  File? _img;
  String _placeCity = '',
      _placeArea = '',
      _placeName = '',
      _placeDescription = '',
      _placePhoneNO = '',
      _placeURL = '',
      _placePicURL = '',
      _placeCategory = '';

  displayImage() {
    if (_img == null) {
      return const AssetImage('image/default.png');
    } else {
      return FileImage(_img!);
    }
  }

  List<String> selectedCity(String s) {
    switch (s) {
      case 'Amman':
        return amman;
      case 'Zarqa':
        return zarqa;
      case 'Irbid':
        return irbid;
      case 'Aqaba':
        return aqaba;
      default:
        return ['please select city'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ImageContainerStackTemplate(
      displayImage(),
      Column(
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
                Container()
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
                      setState(
                        () {
                          _img = File(image!.path);
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
                    final PickedFile? image = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    setState(
                      () {
                        _img = File(image!.path);
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
      Padding(
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
                ' Name',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val) {
                  setState(
                    () {
                      _placeName = val;
                    },
                  );
                },
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  fillColor: const Color(0x33ffffff),
                  filled: true,
                  hintText: 'Your Place Name',
                  hintStyle: const TextStyle(color: Colors.white, fontSize: 20),
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
                    borderSide:
                        const BorderSide(color: Color(0x22ffffff), width: 3.0),
                  ),
                ),
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
                onChanged: (val) {
                  setState(
                    () {
                      _placeDescription = val;
                    },
                  );
                },
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
                    borderSide:
                        const BorderSide(color: Color(0x22ffffff), width: 3.0),
                  ),
                  hintText: 'Write description of your place',
                  hintStyle: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            const Text(
              ' Category',
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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => setState(()=>_placeCategory = 'gaming'),
                    child: Categoryaddplace(
                        'image/gaming-category.png', _placeCategory == 'gaming' ? const Color(0xb83AAEC2):const Color(0x55ffffff)),
                  ),
                  GestureDetector(
                    onTap: () => setState(()=>_placeCategory = 'tourism'),
                    child: Categoryaddplace(
                        'image/tourism-category.png', _placeCategory == 'tourism' ? const Color(0xb83AAEC2):const Color(0x55ffffff)),
                  ),
                  GestureDetector(
                    onTap: () => setState(()=>_placeCategory = 'relax'),
                    child: Categoryaddplace(
                        'image/relax-category.png',_placeCategory == 'relax' ? const Color(0xb83AAEC2):const Color(0x55ffffff)),
                  ),
                ],
              ),
            ),
            const Text(
              ' AVG Cost Per Person',
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
                    _costPerPerson.round().toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 33),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'JD',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Slider(
              value: _costPerPerson,
              min: 0,
              max: 25,
              divisions: 25,
              activeColor: const Color(0xff3AAEC2),
              inactiveColor: const Color(0xffffffff),
              onChanged: (newValue) {
                setState(
                  () {
                    _costPerPerson = newValue;
                  },
                );
              },
            ),
            const Text(
              ' Location',
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
              padding: const EdgeInsets.only(top: 16.0),
              child: Dropdownbox(
                const ['Amman', 'Zarqa', 'Aqaba', 'Irbid'],
                'Select your City',
                (val) {
                  setState(
                    () {
                      _placeCity = val;
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Dropdownbox(
                selectedCity(_placeCity),
                'Select your Area',
                (val) {
                  _placeArea = val;
                },
              ),
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
                onChanged: (val) {
                  setState(
                    () {
                      _placePhoneNO = val;
                    },
                  );
                },
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  fillColor: const Color(0x33ffffff),
                  filled: true,
                  hintText: 'Phone NO',
                  hintStyle: const TextStyle(color: Colors.white, fontSize: 20),
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
                    borderSide:
                        const BorderSide(color: Color(0x22ffffff), width: 3.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val) {
                  setState(
                    () {
                      _placeURL = val;
                    },
                  );
                },
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  fillColor: const Color(0x33ffffff),
                  filled: true,
                  hintText: 'Website / FB Page URL',
                  hintStyle: const TextStyle(color: Colors.white, fontSize: 20),
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
                    borderSide:
                        const BorderSide(color: Color(0x22ffffff), width: 3.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () async {
                  if (_costPerPerson != 0 &&
                      _placeName.isNotEmpty &&
                      _placeDescription.isNotEmpty &&
                      _placeCategory.isNotEmpty &&
                      _placeCity.isNotEmpty &&
                      _placeArea.isNotEmpty &&
                      _placePhoneNO.isNotEmpty &&
                      _placeURL.isNotEmpty &&
                      _img != null) {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => WaitingDialog(),
                    );
                    _placePicURL = await StorageService.uploadPlacePicture(
                        _placePicURL, _img!);
                    AddPlaceServices.addPlace(
                        AuthServices.signedInUser.id,
                        _costPerPerson,
                        _placeName,
                        _placeDescription,
                        _placeCity,
                        _placeArea,
                        _placePhoneNO,
                        _placeURL,
                        _placePicURL,
                        _placeCategory);
                    AuthServices.signedInUser.ownedPlacesIds
                        .add('$_placeName-$_placeArea');
                    Navigator.pop(context);
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
                  } else {
                    if (_costPerPerson == 0 ||
                        _placeName.isEmpty ||
                        _placeDescription.isEmpty ||
                        _placeCategory.isEmpty ||
                        _placeCity.isEmpty ||
                        _placeArea.isEmpty ||
                        _placePhoneNO.isEmpty ||
                        _placeURL.isEmpty) {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => ErrorDialog(
                          title: 'Sorry',
                          text:
                              'All of fields are required,\nPlease fill all of them.',
                        ),
                      );
                    } else if (_img == null) {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => ErrorDialog(
                          title: 'Invalid Image',
                          text:
                              'Please select image from gallery ,\nOr take one from camera.',
                        ),
                      );
                    } else {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => ErrorDialog(
                          title: 'Invalid Location',
                          text:
                              'Please mark a place location\non the map "Set Location" .',
                        ),
                      );
                    }
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
  }
}
