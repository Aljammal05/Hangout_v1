import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v1/ChangePasswordPage.dart';
import 'package:flutter_v1/EditInfoPage.dart';
import 'package:flutter_v1/MenuDrawerPage.dart';
import 'package:flutter_v1/ProfilePage.dart';
import 'package:flutter_v1/Services/AuthServices.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawerPage(),
      body: Builder(
        builder: (context) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xff02ECB9),
                Color(0xff0C89C3)
              ], // red to yellow
              tileMode: TileMode.repeated,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 35),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 15,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 55.0),
                          child: Text(
                            'Settings',
                            style: TextStyle(fontSize: 27, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric( horizontal: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SettingsContainer(
                        Icons.lock,
                        ChangePasswordPage(),
                        'Security',
                        'Change Password '),
                    SettingsContainer(
                        Icons.edit,
                        EditInfoPage(),
                        'Me',
                        AuthServices.signedInUser.name),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Contact us',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50.0),
                      child: Text(
                        '+962787654321',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50.0),
                      child: Text(
                        'T3leleh@gmail.com',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsContainer extends StatefulWidget {
  SettingsContainer(this.icon, this.nextpage, this.text1, this.text2);
  IconData icon;
  Widget nextpage;
  String text1;
  String text2;
  @override
  _SettingsContainerState createState() => _SettingsContainerState();
}

class _SettingsContainerState extends State<SettingsContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SafeArea(child: widget.nextpage);
          }));
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(7.5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Color(0x52ffffff),
          ),
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  widget.icon,
                  color: Colors.white,
                  size: 27,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.text1,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    widget.text2,
                    style: TextStyle(fontSize: 16, color: Colors.white),
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
