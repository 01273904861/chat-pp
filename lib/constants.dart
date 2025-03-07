import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const Color kBlue = Colors.blue;
const Color kWhite = Colors.white;
const Color kBlack = Colors.black;
const Color kPrimaryColor = Color(0xFF0051CE);
const Color kPagesColor = Color(0xffF1F2F4);
const Color kDefaultColor = Color.fromARGB(255, 91, 124, 151);

const String kMessages = 'messages';

CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');

const String kUserName = 'username';
const String kUsernumber = 'usernumber';
const String kUserID = 'userid';
const String kUserImage = 'userimage';

CollectionReference chatrooms =
    FirebaseFirestore.instance.collection('chatrooms');
