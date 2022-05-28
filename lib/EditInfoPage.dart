import 'package:flutter/material.dart';
import 'package:flutter_v1/Dialogs/Dialogs.dart';
import 'package:flutter_v1/Services/AuthServices.dart';
import 'package:flutter_v1/constants/constants.dart';

import 'Templates/SignInPageTemplate.dart';
import 'Widgets/BuildTextField.dart';
import 'Widgets/LinearColoredButton.dart';

class EditInfoPage extends StatefulWidget {
  const EditInfoPage({Key? key}) : super(key: key);

  @override
  _EditInfoPageState createState() => _EditInfoPageState();
}

class _EditInfoPageState extends State<EditInfoPage> {
  String? _changedCity;
  String _name = '';
  @override
  Widget build(BuildContext context) {
    return SignInPageTemplate(
      pageTittle: 'Edit Info',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 30),
              child: Text(
                'Full Name',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: BuildTextField(
                prefixIcon: Icons.person,
                hint: AuthServices.signedInUser.name,
                onChanged: (val) {
                  _name = val;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 30),
              child: Text(
                'City / Area',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Material(
                elevation: 6,
                shadowColor: Colors.grey,
                borderRadius: const BorderRadius.all(
                  Radius.circular(90),
                ),
                child: SizedBox(
                  height: 60,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 45, right: 28),
                      child: DropdownButton(
                        underline: Container(
                          height: 0,
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconSize: 30,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 22,
                        ),
                        isExpanded: true,
                        menuMaxHeight: 200,
                        dropdownColor: const Color(0xffffffff),
                        iconEnabledColor: Colors.grey,
                        hint: Text(
                          'Select New City',
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 16),
                        ),
                        items: ['Amman', 'Zarqa', 'Irbid', 'Aqaba']
                            .map((String item) => DropdownMenuItem<String>(
                                child: Text(item), value: item))
                            .toList(),
                        onChanged: (val) {
                          setState(
                            () {
                              _changedCity = val as String?;
                            },
                          );
                        },
                        value: _changedCity,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 160.0),
              child: GestureDetector(
                onTap: () {
                  setState(
                    () {
                      if (_name.isEmpty && _changedCity == null) {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const ErrorDialog(
                            title: 'Invalid Input',
                            text:
                                'You haven\'t make any changes,\nPlease try again. ',
                          ),
                        );
                      } else {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const WaitingDialog(),
                        );
                        if (_name.isNotEmpty) {
                          usersReference.doc(AuthServices.signedInUser.id).update(
                            {
                              'name': _name,
                            },
                          );
                          AuthServices.signedInUser.name = _name;
                        }
                        if (_changedCity != null) {
                          usersReference.doc(AuthServices.signedInUser.id).update(
                            {
                              'city': _changedCity.toString(),
                            },
                          );
                          AuthServices.signedInUser.city = _changedCity!;
                        }
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    },
                  );
                },
                child: const LinearColoredButton(
                  buttonTittle: 'SAVE',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
