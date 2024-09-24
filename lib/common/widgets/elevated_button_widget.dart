import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  ElevatedButtonWidget({
    super.key,
    required this.callBack,
    this.buttonTitle = "Add Now",
    this.backgroundColor = Colors.blue,
  });

  final VoidCallback callBack;

  Color backgroundColor;

  String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.0),
        ),
      ),
      onPressed: callBack,
      child: Text(
        buttonTitle,
        style: const TextStyle(
          fontSize: 20.0,
        ),
      ),
    );
  }
}
