import 'package:flutter/material.dart';
import 'package:my_chat_2/constants.dart';

class SearchText extends StatelessWidget {
 const SearchText(
      {super.key,
      this.onChanged,
      this.controller,
      this.onPressedButton,
      this.onSubmitted});
 final Function(String)? onChanged;
 final Function(String)? onSubmitted;
 final TextEditingController? controller;
 final void Function()? onPressedButton;
//final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'search user ',
          hintStyle: TextStyle(fontSize: 19, color: kWhite),
          border: InputBorder.none,
          // suffixIcon: IconButton(
          //   onPressed: onPressedButton,
          //   icon: Icon(
          //     Icons.search,
          //     color: kWhite,
          //   ),
          //   iconSize: 25,
          // ),
        ),
      ),
    );
  }
}
