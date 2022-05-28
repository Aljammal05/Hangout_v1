import 'package:flutter/material.dart';

class BuildPasswordTextField extends StatefulWidget {
  const BuildPasswordTextField({required this.onChanged, Key? key})
      : super(key: key);

  final Function onChanged;

  @override
  _BuildPasswordTextFieldState createState() => _BuildPasswordTextFieldState();
}

class _BuildPasswordTextFieldState extends State<BuildPasswordTextField> {
  Color suffixIconColor = Colors.grey;
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      shadowColor: Colors.grey,
      borderRadius: const BorderRadius.all(
        Radius.circular(90),
      ),
      child: TextField(
        onChanged: (String val) {
          widget.onChanged(val);
        },
        keyboardType: TextInputType.visiblePassword,
        obscureText: obscureText,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(90),
            ),
            borderSide: BorderSide(
              color: Color(0x0000ffff),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(90.0),
            borderSide: const BorderSide(color: Color(0x0000ffff), width: 3.0),
          ),
          hintText: 'Password',
          prefixIcon: const Padding(
            padding: EdgeInsets.all(16),
            child: Icon(
              Icons.lock,
              size: 30,
              color: Colors.grey,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(
                    () {
                  if (suffixIconColor == Colors.grey) {
                    suffixIconColor = Colors.blue;
                    obscureText = false;
                  } else {
                    suffixIconColor = Colors.grey;
                    obscureText = true;
                  }
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Icon(
                Icons.visibility,
                size: 30,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}