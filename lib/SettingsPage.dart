import 'package:flutter/material.dart';
import 'package:flutter_v1/ChangePasswordPage.dart';
import 'package:flutter_v1/EditInfoPage.dart';
import 'package:flutter_v1/MenuDrawerPage.dart';
import 'package:flutter_v1/Services/AuthServices.dart';
import 'package:flutter_v1/constants/constants.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawerPage(),
      body: Builder(
        builder: (context) => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: linearGradiantColors, // red to yellow
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
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 15,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(right: 55.0),
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
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SettingsContainer(
                        icon: Icons.lock,
                        destination: ChangePasswordPage(),
                        tittle: 'Security',
                        hint: 'Change Password '),
                    SettingsContainer(
                        icon: Icons.edit,
                        destination: const EditInfoPage(),
                        tittle: 'Me',
                        hint: AuthServices.signedInUser.name),
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
                        'Hangout@gmail.com',
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
  const SettingsContainer(
      {required this.icon,
      required this.destination,
      this.tittle = '',
      this.hint = '',
      Key? key})
      : super(key: key);
  final IconData icon;
  final Widget destination;
  final String tittle;
  final String hint;
  @override
  _SettingsContainerState createState() => _SettingsContainerState();
}

class _SettingsContainerState extends State<SettingsContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SafeArea(child: widget.destination);
                },
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(7.5),
        child: Container(
          decoration: const BoxDecoration(
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
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.tittle,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    widget.hint,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
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
