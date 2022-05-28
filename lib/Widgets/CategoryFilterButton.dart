import 'package:flutter/material.dart';
import 'package:flutter_v1/constants/constants.dart';

class CategoryFilterButton extends StatefulWidget {
  const CategoryFilterButton({required this.imagePath, required this.onTap, Key? key})
      : super(key: key);
  final String imagePath;
  final Function onTap;
  @override
  _CategoryFilterButtonState createState() => _CategoryFilterButtonState();
}

class _CategoryFilterButtonState extends State<CategoryFilterButton> {
  Color backcolor = const Color(0x55ffffff);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          setState(
                () {
              backcolor = backcolor == const Color(0x55ffffff)
                  ? secondaryColorHalfOpacity
                  : const Color(0x55ffffff);
              widget.onTap();
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            color: backcolor,
            image: DecorationImage(
                image: AssetImage(widget.imagePath), fit: BoxFit.cover),
          ),
          height: 90,
          width: 90,
        ),
      ),
    );
  }
}