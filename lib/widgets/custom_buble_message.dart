import 'package:flutter/material.dart';

import 'package:my_chat_2/constants.dart';

class BubleSendMessage extends StatelessWidget {
  const BubleSendMessage({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        margin: const EdgeInsets.only(top: 3, left: 5),
        padding: const EdgeInsets.all(18),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(5),
            ),
            color: Color.fromARGB(255, 110, 112, 112)),
        child: Text(
          text,
          style: const TextStyle(fontSize: 17, color: kWhite),
        ),
      ),
    );
  }
}

class BubleReceiveMessage extends StatelessWidget {
  const BubleReceiveMessage({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        margin: const EdgeInsets.only(top: 3, right: 5),
        padding: const EdgeInsets.all(18),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(5),
            bottomLeft: Radius.circular(20),
          ),
          color: Colors.blueGrey,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 17, color: kWhite),
        ),
      ),
    );
  }
}
