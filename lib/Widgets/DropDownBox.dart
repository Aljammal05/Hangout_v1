import 'package:flutter/material.dart';
import 'package:flutter_v1/constants/constants.dart';

class DropDownBox extends StatefulWidget {
  const DropDownBox(
      {required this.values,
        required this.hint,
        required this.onSelect,
        Key? key})
      : super(key: key);

  final List<String> values;
  final Function onSelect;
  final String hint;

  @override
  _DropDownBoxState createState() => _DropDownBoxState();
}

class _DropDownBoxState extends State<DropDownBox> {
  String? selectedItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color(0x33ffffff),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: DropdownButton(
          underline: Container(
            height: 0,
          ),
          icon: const Icon(Icons.keyboard_arrow_down),

          iconSize: 30,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 23,
          ),
          isExpanded: true,
          //menuMaxHeight: 200,
          dropdownColor: secondaryColorHalfOpacity,
          iconEnabledColor: Colors.white,
          hint: Text(
            widget.hint,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          items: widget.values
              .map(
                (String item) =>
                DropdownMenuItem<String>(child: Text(item), value: item),
          )
              .toList(),
          onChanged: (val) {
            setState(
                  () {
                selectedItem = val as String?;
                widget.onSelect(val);
              },
            );
          },
          value: selectedItem,
        ),
      ),
    );
  }
}