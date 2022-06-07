import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v1/Services/AuthServices.dart';
import 'package:flutter_v1/SignInPage.dart';
import 'package:flutter_v1/constants/constants.dart';
import 'package:flutter_v1/models/UserModel.dart';
import 'Dialogs/Dialogs.dart';
import 'Templates/SignInPageTemplate.dart';
import 'Widgets/BuildPasswordTextField.dart';
import 'Widgets/BuildTextField.dart';
import 'Widgets/LinearColoredButton.dart';

class EditEmailPage extends StatefulWidget {
  const EditEmailPage({Key? key, this.email = ''}) : super(key: key);
  final String email;
  @override
  _EditEmailPageState createState() => _EditEmailPageState();
}

class _EditEmailPageState extends State<EditEmailPage> {
  String _email = '', _password = '';

  void changeEmail(String newEmail, String currentPassword) async{
    final user = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: widget.email, password: currentPassword);
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const WaitingDialog(),
    );

    await user!.reauthenticateWithCredential(cred).then(
      (value) async{
        await user.updateEmail(newEmail).then(
          (_) async{
            await usersReference
                .doc(AuthServices.signedInUser.id)
                .update({'email': newEmail});
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
            );
          },
        ).catchError(
          (error) {
            Navigator.pop(context);
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (context) => const ErrorDialog(
                title: 'Invalid Email',
                text:
                    'This email address is not available.\nChoose a different address.',
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
            text: 'Password you entered is incorrect.\nPlease try again.',
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SignInPageTemplate(
      pageTittle: 'Change Email',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 30),
              child: Text(
                'New Email',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: BuildTextField(
                prefixIcon: Icons.email,
                hint: widget.email,
                onChanged: (val) {
                  _email = val;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 30),
              child: Text(
                'Enter your password',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: BuildPasswordTextField(
                onChanged: (val) {
                  _password = val;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 160.0),
              child: GestureDetector(
                onTap: () {
                  setState(
                    () {
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
                        changeEmail(_email, _password);
                      }
                    },
                  );
                },
                child: const LinearColoredButton(
                  buttonTittle: 'CHANGE',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
