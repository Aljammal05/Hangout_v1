import 'package:flutter/material.dart';
import 'package:flutter_v1/Admin/AdminDashBoard.dart';
import 'package:flutter_v1/User/DashboardPage.dart';
import 'package:flutter_v1/Dialogs/Dialogs.dart';
import 'package:flutter_v1/RecoveryPage.dart';
import 'package:flutter_v1/RegisterPage.dart';
import 'package:flutter_v1/Services/AuthServices.dart';
import 'package:flutter_v1/constants/constants.dart';

import 'Owner/OwnedPlacesPage.dart';
import 'Templates/SignInPageTemplate.dart';
import 'Widgets/BuildPasswordTextField.dart';
import 'Widgets/BuildTextField.dart';
import 'Widgets/LinearColoredButton.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String _email = '', _password = '';
  @override
  Widget build(BuildContext context) {
    return SignInPageTemplate(
      canGoBack: false,
      pageTittle: 'Login',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: BuildTextField(
                prefixIcon: Icons.email,
                hint: 'Email',
                onChanged: (val) {
                  _email = val;
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 16),
                child: BuildPasswordTextField(
                  onChanged: (val) {
                    _password = val;
                  },
                )),
            TextButton(
              onPressed: () {
                setState(
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SafeArea(child: RecoveryPage());
                        },
                      ),
                    );
                  },
                );
              },
              child: const Text(
                'Forgot password ?',
                style: TextStyle(
                  color: secondaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            GestureDetector(
              onTap: () async {
                if (_email.isEmpty || _password.isEmpty) {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const ErrorDialog(
                      title: 'Sorry',
                      text:
                          'All of fields are required,\nplease fill all of them.',
                    ),
                  );
                } else {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const WaitingDialog(),
                  );
                  bool isValid = await AuthServices.signIn(_email, _password);
                  String userType = AuthServices.signedInUser.userType;
                  if (isValid) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SafeArea(
                            child: userType == 'user'
                                ? const DashboardPage()
                                : userType == 'owner'
                                    ? const OwnedPlacesPage()
                                    : const AdminDashBoard(),
                          );
                        },
                      ),
                    );
                  } else {
                    Navigator.pop(context);
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const ErrorDialog(
                        title: 'Wrong Input',
                        text:
                            'This email or password is wrong.\nPlease try again.',
                      ),
                    );
                  }
                }
              },
              child: const LinearColoredButton(
                buttonTittle: 'LOGIN',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const SafeArea(child: RegisterPage());
                      },
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account ? ',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 18,
                        color: secondaryColor,
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
