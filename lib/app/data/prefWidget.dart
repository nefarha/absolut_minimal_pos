import 'package:flutter/material.dart';

class PreferredWidget {
  static customTextfield(
      {required TextEditingController textController,
      required String label,
      bool isNumber = false,
      Icon? prefIcon}) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        width: 400,
        child: TextField(
          controller: textController,
          keyboardType: (isNumber) ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: prefIcon,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
