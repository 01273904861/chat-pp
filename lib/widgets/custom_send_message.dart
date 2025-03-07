import 'package:flutter/material.dart';

class SendMessageTextForm extends StatelessWidget {
  const SendMessageTextForm(
      {super.key, this.onSubmitted, this.controller, this.onPressedButton});
  final Function(String)? onSubmitted;
  final TextEditingController? controller;
  final void Function()? onPressedButton;
//final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        onSubmitted: onSubmitted,
        controller: controller,
        decoration: InputDecoration(
            hintText: 'write a message .. ',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            suffixIcon: IconButton(
                onPressed: onPressedButton,
                icon: const Icon(Icons.send_outlined))),
      ),
    );
  }
}
