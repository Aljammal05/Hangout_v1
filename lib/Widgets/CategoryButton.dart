import 'package:flutter/material.dart';

class CategoryButton extends StatefulWidget {
  CategoryButton({required this.imagePath, required this.backcolor, Key? key})
      : super(key: key);
  final String imagePath;
  Color backcolor;

  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          color: widget.backcolor,
          image: DecorationImage(
              image: AssetImage(widget.imagePath), fit: BoxFit.cover),
        ),
        height: 90,
        width: 90,
      ),
    );
  }
}
