

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v1/DashboardPage.dart';
import 'package:flutter_v1/FavoritesPage.dart';
import 'package:flutter_v1/FilterPage.dart';
import 'package:flutter_v1/OwnedPlacesPage.dart';
import 'package:flutter_v1/ProfilePage.dart';
import 'package:flutter_v1/Services/AuthServices.dart';
import 'package:flutter_v1/SettingsPage.dart';
import 'package:flutter_v1/SignInPage.dart';

class MenuDrawerPage extends StatefulWidget {
  const MenuDrawerPage({Key? key}) : super(key: key);

  @override
  _MenuDrawerPageState createState() => _MenuDrawerPageState();
}

class _MenuDrawerPageState extends State<MenuDrawerPage> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    if (AuthServices.signedInUser.userType.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: Color(0x00ffffff),
          valueColor: AlwaysStoppedAnimation(Color(0x00ffffff)),
        ),
      );
    }
    MediaQueryData mq = MediaQuery.of(context);
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          height: mq.size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xff02ECB9),
              Color(0xff0C89C3)
            ], // red to yellow
            tileMode: TileMode.repeated,
          )),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const SafeArea(child: ProfilePage());
                                },
                              ),
                            );
                          },
                        );
                      },
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: AuthServices
                                .signedInUser.profilePicURL.isEmpty
                            ? const AssetImage('image/profile-default-pic.jpg')
                            : NetworkImage(
                                    AuthServices.signedInUser.profilePicURL)
                                as ImageProvider,
                        backgroundColor: const Color(0x00ffffff),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        AuthServices.signedInUser.name,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(AuthServices.signedInUser.city,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        )),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: MenuContainer(
                              Icons.dashboard,
                              AuthServices.signedInUser.userType == 'user'
                                  ? const DashboardPage()
                                  : const OwnedPlacesPage(),
                              () {}),
                        ),
                        Expanded(
                          flex: 1,
                          child:
                              MenuContainer(Icons.person, const ProfilePage(), () {}),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: AuthServices.signedInUser.userType == 'user'
                              ? MenuContainer(
                                  Icons.favorite, const FavoritesPage(), () {})
                              : MenuContainer(
                                  Icons.settings, SettingPage(), () {}),
                        ),
                        Expanded(
                          flex: 1,
                          child: AuthServices.signedInUser.userType == 'user'
                              ? MenuContainer(
                                  Icons.settings, SettingPage(), () {})
                              : MenuContainer(
                                  Icons.logout,
                                  const SignInPage(),
                                  () async {
                                    _auth.signOut();
                                  },
                                ),
                        )
                      ],
                    ),
                    AuthServices.signedInUser.userType == 'user'
                        ? Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: MenuContainer(
                                      Icons.explore, const FilterPage(), () {})),
                              Expanded(
                                flex: 1,
                                child: MenuContainer(
                                    Icons.logout, const SignInPage(), () async {
                                  _auth.signOut();
                                }),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Contact us',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50.0),
                        child: Text(
                          '+962787654321',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50.0),
                        child: Text(
                          'T3leleh@gmail.com',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuContainer extends StatefulWidget {//todo refactor

  const MenuContainer(this.icon, this.destination, this.onTap, {Key? key}) : super(key: key);
  final IconData icon;
  final Widget destination;
  final Function onTap;
  @override
  _MenuContainerState createState() => _MenuContainerState();
}

class _MenuContainerState extends State<MenuContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onTap();
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SafeArea(child: widget.destination);
          }));
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Color(0x52ffffff),
          ),
          height: 90,
          child: Icon(
            widget.icon,
            color: Colors.white,
            size: 23,
          ),
        ),
      ),
    );
  }
}
