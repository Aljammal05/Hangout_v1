import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v1/models/UserModel.dart';
import 'package:flutter_v1/Services/AuthServices.dart';
import 'package:flutter_v1/SignInPage.dart';
import 'package:flutter_v1/constants/constants.dart';
import 'Dialogs/Dialogs.dart';
import 'Templates/SignInPageTemplate.dart';
import 'Widgets/BuildTextField.dart';
import 'Widgets/LinearColoredButton.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String _oldPassword = '', _newPassword = '', _confirmPassword = '';

  void _changePassword(String currentPassword, String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;
    String email = AuthServices.signedInUser.email;
    final cred =
        EmailAuthProvider.credential(email: email, password: currentPassword);

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const WaitingDialog(),
    );
    await user!.reauthenticateWithCredential(cred).then(
      (value) async{
       await user.updatePassword(newPassword).then(
          (_) async{
            await usersReference.doc(AuthServices.signedInUser.id).update(
              {'password': newPassword},
            );
            AuthServices.signedInUser = UserModel();
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const SafeArea(
                    child: SignInPage(),
                  );
                },
              ),
            ); //Success, do something
          },
        ).catchError(
          (error) {
            Navigator.pop(context);
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (context) => const ErrorDialog(
                title: 'Invalid Password',
                text:
                    'The password you entered is invalid.\nMake sure it have 8 digits or more.',
              ),
            );
          },
        );
      },
    ).catchError(
      (err) {
        Navigator.pop(context);
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (context) => const ErrorDialog(
            title: 'Incorrect Password',
            text: 'Your old password is incorrect.\nPlease try again.',
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SignInPageTemplate(
      pageTittle: 'Change Password',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: BuildTextField(
                prefixIcon: Icons.lock,
                hint: 'Old Password',
                onChanged: (val) {
                  _oldPassword = val;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 21.0),
              child: BuildTextField(
                prefixIcon: Icons.lock,
                hint: 'New Password',
                onChanged: (val) {
                  _newPassword = val;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 21.0),
              child: BuildTextField(
                prefixIcon: Icons.lock,
                hint: 'Confirm Password',
                onChanged: (val) {
                  _confirmPassword = val;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 105.0),
              child: GestureDetector(
                onTap: () {
                  if (_newPassword.length < 8) {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const ErrorDialog(
                        title: 'Invalid Password',
                        text:
                            'Please make sure your password \ncontain 8 digits or more',
                      ),
                    );
                  } else if (_newPassword == _confirmPassword) {
                    _changePassword(_oldPassword, _newPassword);
                  } else {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const ErrorDialog(
                        title: 'Doesn\'t Match',
                        text: 'Please make sure your passwords \nare match',
                      ),
                    );
                  }
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
