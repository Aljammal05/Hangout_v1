import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v1/Admin/AcceptedPlaces.dart';
import 'package:flutter_v1/Admin/PendingPlaces.dart';
import 'package:flutter_v1/SignInPage.dart';
import 'package:flutter_v1/constants/constants.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({Key? key}) : super(key: key);

  @override
  _AdminDashBoardState createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  int _selectedTap = 1;
  final List<Widget> _dashboard = [
    const AcceptedPlaces(),
    const PendingPlaces(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(15.0),
            child: IconButton(
              onPressed: () async {
                final _auth = FirebaseAuth.instance;
                _auth.signOut();
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
              icon: const Icon(
                Icons.logout,
                size: 30,
              ),
            ),
          ),
          backgroundColor: secondaryColor,
          toolbarHeight: 80,
          title: const Text(
            'DashBoard',
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: _dashboard.elementAt(_selectedTap),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(
              () {
                _selectedTap = index;
              },
            );
          },
          currentIndex: _selectedTap,
          fixedColor: Colors.white,
          backgroundColor: secondaryColor,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle), label: 'accepted'),
            BottomNavigationBarItem(
                icon: Icon(Icons.pending), label: 'pending'),
          ],
        ),
      ),
    );
  }
}
