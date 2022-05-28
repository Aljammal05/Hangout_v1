import 'package:flutter/material.dart';
import 'package:flutter_v1/Services/AuthServices.dart';
import 'package:flutter_v1/Templates/Templates.dart';
import 'Dialogs/Dialogs.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int _toggleValue = 0;
  String _name = '', _email = '', _password = '', _phoneNO = '', _city = '';
  var _changedCity;

  @override
  Widget build(BuildContext context) {
    return SignInPageTemplate(
      pageTittle: 'Register',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                height: 330,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Material(
                            elevation: 4,
                            shadowColor: Colors.grey,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(90),
                            ),
                            child: AnimatedToggle(onToggleCallback: (value) {
                              setState(
                                () {
                                  _toggleValue = value;
                                },
                              );
                            }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 36.0),
                          child: BuildTextField(
                            prefixIcon: Icons.person,
                            hint: 'FullName',
                            onChanged: (val) {
                              _name = val;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: BuildTextField(
                            prefixIcon: Icons.email,
                            hint: 'Email',
                            onChanged: (val) {
                              _email = val;
                            },
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: BuildPasswordTextField(
                              onChanged: (val) {
                                _password = val;
                              },
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: BuildTextField(
                            prefixIcon: Icons.phone,
                            hint: 'Phone number',
                            onChanged: (val) {
                              _phoneNO = val;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
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
                                  padding: const EdgeInsets.only(
                                      left: 45, right: 28),
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
                                      'Select Your City',
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 16),
                                    ),
                                    items: ['Amman', 'Zarqa', 'Irbid', 'Aqaba']
                                        .map(
                                          (String item) =>
                                              DropdownMenuItem<String>(
                                                  child: Text(item),
                                                  value: item),
                                        )
                                        .toList(),
                                    onChanged: (val) {
                                      setState(
                                        () {
                                          _changedCity = val;
                                          _city = val.toString();
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
              child: GestureDetector(
                onTap: () {
                  if (_email.isEmpty ||
                      _password.isEmpty ||
                      _name.isEmpty ||
                      _phoneNO.isEmpty ||
                      _city.isEmpty) {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => ErrorDialog(
                        title: 'Sorry',
                        text:
                            'All of fields are required,\nplease fill all of them.',
                      ),
                    );
                  } else if (_password.length < 8) {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => ErrorDialog(
                        title: 'Invalid Password',
                        text:
                            'Please make sure your password \ncontain 8 digits or more',
                      ),
                    );
                  } else {
                    try {
                      setState(
                        () async {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => WaitingDialog(),
                          );
                          bool isValid = await AuthServices.signUp(
                              _name,
                              _email,
                              _password,
                              _phoneNO,
                              _city,
                              _toggleValue == 0 ? 'owner' : 'user',
                              context);
                          if (isValid) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        },
                      );
                    } catch (e) {
                      Navigator.pop(context);
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => ErrorDialog(
                          title: 'ERROR',
                          text: e.toString(),
                        ),
                      );
                    }
                  }
                },
                child: const LinearColoredButton(
                  buttonTittle: 'REGISTER',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member ? ',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff08AFBF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
