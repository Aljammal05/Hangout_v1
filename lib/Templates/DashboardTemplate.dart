
import 'package:flutter/material.dart';
import 'package:flutter_v1/constants/constants.dart';

import '../MenuDrawerPage.dart';

class DashboardTemplate extends StatefulWidget {
  const DashboardTemplate(
      {this.linearTopColor = const Color(0xb8E1D0C1),
        this.linearBottomColor = const Color(0xb83AAEC2),
        this.backgroundImagePath = 'image/deadsea.jpg',
        this.pageTittle = 'Tittle',
        required this.child,
        Key? key})
      : super(key: key);

  final Color linearTopColor;
  final Color linearBottomColor;
  final String backgroundImagePath;
  final String pageTittle;
  final Widget child;

  @override
  _DashboardTemplateState createState() => _DashboardTemplateState();
}

class _DashboardTemplateState extends State<DashboardTemplate> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const MenuDrawerPage(),
        body: Builder(
          builder: (context) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.backgroundImagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: linearGradiantColorsHalfOpacity, // red to yellow
                        tileMode: TileMode.repeated,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(
                                    () {
                                  Scaffold.of(context).openDrawer();
                                },
                              );
                            },
                            child: const Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          Center(
                            child: Text(
                              widget.pageTittle,
                              style: const TextStyle(
                                  fontSize: 27, color: Colors.white),
                            ),
                          ),
                          Container(
                            width: 30,
                          )
                        ],
                      ),
                    ),
                    height: 100,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: linearGradiantColorsHalfOpacity, // red to yellow
                          tileMode: TileMode.repeated,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 16),
                        child: SingleChildScrollView(child: widget.child),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}