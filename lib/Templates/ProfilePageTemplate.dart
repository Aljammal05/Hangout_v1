

import 'package:flutter/material.dart';
import 'package:flutter_v1/constants/constants.dart';

class ProfilePageTemplate extends StatelessWidget {
  const ProfilePageTemplate(
      {required this.image,
        required this.topChild,
        required this.bottomChild,
        Key? key})
      : super(key: key);

  final ImageProvider image;
  final Widget topChild;
  final Widget bottomChild;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 390,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('image/default.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Container(),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
                height: 390,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: topChild),
          ),
          Positioned(
            top: 235,
            bottom: 0,
            child: Container(
              height: mq.size.height - 300,
              width: mq.size.width + 0.3,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: linearGradiantColors, // red to yellow
                  tileMode: TileMode.repeated,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(child: bottomChild),
              ),
            ),
          ),
        ],
        fit: StackFit.expand,
      ),
    );
  }
}