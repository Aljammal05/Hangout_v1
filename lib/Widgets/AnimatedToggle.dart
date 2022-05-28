import 'package:flutter/material.dart';
import 'package:flutter_v1/constants/constants.dart';

class AnimatedToggle extends StatefulWidget {
  const AnimatedToggle({required this.onToggleCallback, Key? key})
      : super(key: key);
  final ValueChanged onToggleCallback;

  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  final List<String> values = const ['Owner', 'User'];
  bool _toggle = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 40,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(45),
        ),
      ),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _toggle = !_toggle;
              var index = 0;
              if (!_toggle) {
                index = 1;
              }
              widget.onToggleCallback(index);
              setState(() {});
            },
            child: Container(
              width: 300,
              height: 40,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  values.length,
                      (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: Text(
                      values[index],
                      style: const TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff9e9e9e),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment: _toggle ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: 300 * 0.5,
              height: 40,
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: linearGradiantColors, // red to yellow
                  tileMode: TileMode.repeated,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  _toggle ? values[0] : values[1],
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}