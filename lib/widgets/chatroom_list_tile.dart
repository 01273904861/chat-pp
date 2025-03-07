import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_2/constants.dart';
import 'package:my_chat_2/screens/chat_page.dart';
import 'package:my_chat_2/services/firebase_methods.dart';
import 'package:my_chat_2/services/shared_prefernces_helper.dart';


class ChatRoomListTilState extends StatefulWidget {
  final String? lastMesssage, chatRoomId, username, id;
 final Function()? ontap;
const  ChatRoomListTilState(
      {super.key,
      this.lastMesssage,
      this.chatRoomId,
      this.id,
      this.username,
      this.ontap});

  @override
  State<ChatRoomListTilState> createState() => _ChatRoomListTilStateState();
}

class _ChatRoomListTilStateState extends State<ChatRoomListTilState> {
  String? image, name, username, id, email, myuserName;
  QuerySnapshot? querySnapshot;
  getThisUserInfo() async {
    myuserName = await SharedPreferencesHelper().getUserName();
    username = widget.username!;
    // widget.chatRoomId!.replaceAll('-', '').replaceAll(widget.myusername!, '');
    _fetchDataFromFirebase();
  }

  void _fetchDataFromFirebase() {
    setState(() {
      // Set _dataStream to null to indicate loading state
      querySnapshot = null;
    });

    // Perform data fetching asynchronously
    Future.delayed(const Duration(seconds: 2), () async {
      // Replace this with your actual Firebase query
      querySnapshot = await FirebaseMethods().getUserDataByUsername(username!);

      setState(() {
        // Update _dataStream with the fetched data
        name = '${querySnapshot!.docs[0]['name']}';
        image = ' ${querySnapshot!.docs[0]['image']}';
        id = ' ${querySnapshot!.docs[0]['id']}';
        email = ' ${querySnapshot!.docs[0]['email']}';
      });
    });
  }

  @override
  @override
  void initState() {
    getThisUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (name == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatPage(
                  email: email!,
                  name: name!,
                  profilePic: image!,
                  username: username!,
                  senderUsername: myuserName!,
                );
              },
            ),
          );
        },
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
                      'https://upload.wikimedia.org/wikipedia/commons/d/d7/Cristiano_Ronaldo_playing_for_Al_Nassr_FC_against_Persepolis%2C_September_2023_%28cropped%29.jpg',
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
                        name!,
                        style: const TextStyle(
                            color: kBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        username!,
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
}
