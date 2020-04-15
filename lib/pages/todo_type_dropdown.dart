import 'package:flutter/material.dart';

class TodoTypeDropdown extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChangeValue;

  TodoTypeDropdown({
    @required this.onChangeValue,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return returnDropDown();
  }

  Widget returnDropDown() {
    return DropdownButton<String>(
      value: selected,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.blueAccent),
      underline: Container(
        height: 2,
        color: Colors.blueAccent,
      ),
      onChanged: onChangeValue,
      items: <String>['DEFAULT', 'LIST', 'HOME_WORK']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
