import 'package:flutter/material.dart';
import 'package:flutter_v1/constants/constants.dart';

class LinearColoredButton extends StatefulWidget {
  const LinearColoredButton({this.buttonTittle = 'Button', Key? key})
      : super(key: key);
  final String buttonTittle;
  @override
  _LinearColoredButtonState createState() => _LinearColoredButtonState();
}

class _LinearColoredButtonState extends State<LinearColoredButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      borderRadius: const BorderRadius.all(
        Radius.circular(90),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(90),
          ),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: linearGradiantColors, // red to yellow
            tileMode: TileMode.repeated,
          ),
        ),
        height: 60,
        width: double.infinity,
        child: Center(
          child: Text(
            widget.buttonTittle,
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ),
    );
  }
}