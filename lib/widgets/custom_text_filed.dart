import 'package:flutter/material.dart';
import 'package:my_chat_2/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hinText,
      this.onChanged,
      required this.icon,
      this.textEditingController});
  final String? hinText;
  final Function(String)? onChanged;
  final IconData icon;
  final TextEditingController? textEditingController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: textEditingController,
        validator: (val) {
          if (val!.isEmpty) {
            return 'this field is required';
          } else if (!checkChars(val) &&
              !checkCapitalChars(val) &&
              !checkNumbers(val)) {
            return 'the field should include numbers or charchters';
          }
          return null;
        },
        style: const TextStyle(
            color: kDefaultColor,
            fontSize: 20,
            fontWeight: FontWeight.bold), //the colo of input text
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
          ),
          hintText: hinText,
          filled: true,
          fillColor: kWhite,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: kBlue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: kWhite),
          ),
        ),

        onChanged: onChanged,
      ),
    );
  }

  bool checkNumbers(String data) {
    return (data.contains(RegExp(r'[0-9]')));
  }

  bool checkChars(String data) {
    return (data.contains(RegExp(r'[a-z]')));
  }

  bool checkCapitalChars(String data) {
    return (data.contains(RegExp(r'[A-Z]')));
  }
}
