import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_2/screens/log_in_page.dart';
import 'package:my_chat_2/services/firebase_methods.dart';

class HelperFunctions {
  void scaffoldMessengerMassage(String message, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  getchatroomIdbyUsersname(String a, String b) {
    //obama , adel

    int minstring = min(a.length, b.length);
    int k = 0;
    for (int i = 0; i < minstring; i++) {
      //ossama , obama ==> b < s
      if (a.substring(i, i + 1) != b.substring(i, i + 1)) {
        //i search for a letter to create id based on it
        k = i;
        break;
      }
    }
    if (a.substring(k, k + 1).codeUnitAt(0) <
        b.substring(k, k + 1).codeUnitAt(0)) {
      return '${a}_$b';
    } else {
      return '${b}_$a';
    }
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Log Out'),
            content: const Text(
              'Do you want to log out ?',
              style: TextStyle(fontSize: 20),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'No',
                  style: TextStyle(fontSize: 19),
                ),
              ),
              TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(LogInPage.id, (route) => false);
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(fontSize: 19),
                ),
              )
            ],
          );
        });
  }

  var usersCurrentChats = [];
  getChats(String username) async {
    List chatedUsers = await FirebaseMethods().getChatedUsers(username);
    //after get the users now fetch theirs data
    usersCurrentChats = [];
    for (var user in chatedUsers) {
      await FirebaseMethods().getUserDataByUsername(user).then(
        // { name , username , ...}
        (QuerySnapshot q) {
          usersCurrentChats.add(q.docs[0].data());
        },
      );
    }
    // for (int i = 0; i < usersCurrentChats.length; i++) {
    //   print(usersCurrentChats[i]);
    // }
  }
}
