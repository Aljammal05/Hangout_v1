import 'package:flutter/material.dart';
import 'package:flutter_v1/constants/constants.dart';

class SignInPageTemplate extends StatefulWidget {
  const SignInPageTemplate(
      {this.canGoBack = true,
      this.pageTittle = 'Tittle',
      required this.child,
      Key? key})
      : super(key: key);

  final String pageTittle;
  final bool canGoBack;
  final Widget child;

  @override
  _SignInPageTemplateState createState() => _SignInPageTemplateState();
}

class _SignInPageTemplateState extends State<SignInPageTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              elevation: 4,
              shadowColor: Colors.grey,
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(130)),
              child: Container(
                height: 239,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(130)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: linearGradiantColors, // red to yellow
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Column(
                  children: [
                    widget.canGoBack
                        ? Expanded(
                            flex: 1,
                            child: Align(
                              child: GestureDetector(
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                                onTap: () {
                                  setState(
                                    () {
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              ),
                              alignment: Alignment.topLeft,
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: SizedBox(
                              height: 28,
                              width: 28,
                            ),
                          ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Image.asset(
                          'image/logo.png',
                          height: 180,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              widget.pageTittle,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                          alignment: Alignment.centerRight),
                    ),
                  ],
                ),
              ),
            ),
            widget.child
          ],
        ),
      ),
    );
  }
}
