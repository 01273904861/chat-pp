import 'package:flutter/material.dart';
import 'package:my_chat_2/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonName,
  });
  final String buttonName;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: kPrimaryColor,
      ),
      child: Center(
        child: Text(
          buttonName,
          style: const TextStyle(
              color: kWhite, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
