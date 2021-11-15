import 'package:flutter/material.dart';

class CustomButton {
  Widget buildEnableButton({
    required bool isButtonEnable,
    required String title,
    required VoidCallback? onPresses,
  }) {
    return Container(
      height: 50.0,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          color: isButtonEnable ? Colors.black : Colors.grey,
          borderRadius: BorderRadius.circular(10.0)),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: onPresses,
          child: Center(
            child: Text(
              title.toUpperCase(),
              style: TextStyle(color: isButtonEnable ? Colors.white : Colors.black).copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
