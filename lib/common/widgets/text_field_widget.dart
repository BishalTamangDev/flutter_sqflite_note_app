import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.label,
    required this.controller,
  });

  final String label;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: label == "Description" ? 10 : 1,
      controller: controller,
      autofocus: label == "Title" ? true : false,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        label: Text(label),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11.0),
        ),
      ),
    );
  }
}
