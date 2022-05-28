import 'package:flutter/material.dart';

class BuildTextField extends StatefulWidget {
  const BuildTextField(
      {this.prefixIcon = Icons.edit,
        this.hint = 'hint',
        required this.onChanged,
        Key? key})
      : super(key: key);

  final IconData prefixIcon;
  final String hint;
  final Function onChanged;

  @override
  _BuildTextFieldState createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
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
          hintText: widget.hint,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(16),
            child: Icon(
              widget.prefixIcon,
              size: 30,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}