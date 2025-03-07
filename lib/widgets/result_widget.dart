import 'package:flutter/material.dart';
import 'package:my_chat_2/constants.dart';

class ResultWdget extends StatelessWidget {
 const ResultWdget({super.key, this.data, this.ontap});
   final  data;
 final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    data['image'],
                    height: 70,
                    width: 65,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['name'],
                      style: const TextStyle(
                          color: kBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      data['username'],
                      style: const TextStyle(
                          color: kBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
