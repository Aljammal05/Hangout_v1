import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v1/Templates/Templates.dart';

class RecoveryPage extends StatefulWidget {
  const RecoveryPage({Key? key}) : super(key: key);

  @override
  _RecoveryPageState createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  String _email = '';
  @override
  Widget build(BuildContext context) {
    return SignInPageTemplate(
      pageTittle: 'Recovery',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Text(
                'Please enter your Email address to\n ' //todo
                'let us send you a recovery code.',
                style: TextStyle(fontSize: 18.0, color: Colors.grey.shade600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'note : you will receive a code within\n '
                '1 minute',
                style: TextStyle(fontSize: 18.0, color: Colors.grey.shade600),
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
            const SizedBox(
              height: 140,
            ),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
                Navigator.pop(context);
              },
              child: const LinearColoredButton(
                buttonTittle: 'SEND',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
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
            ),
          ],
        ),
      ),
    );
  }
}
