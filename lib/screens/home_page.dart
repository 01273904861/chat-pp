import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_2/constants.dart';
import 'package:my_chat_2/functions/helper_functions.dart';
import 'package:my_chat_2/screens/chat_page.dart';
import 'package:my_chat_2/services/firebase_methods.dart';
import 'package:my_chat_2/services/shared_prefernces_helper.dart';
import 'package:my_chat_2/widgets/chatroom_list_tile.dart';
import 'package:my_chat_2/widgets/result_widget.dart';
import 'package:my_chat_2/widgets/search__text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String id = 'home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String myname = '';
  String myEmail = '';
  String myuserName = '';
  String myProfilePic = '';
  bool search = false;
  var usersChats = [];
  Stream? chatStream;
  var x;

  ontheLoad() async {
    SharedPreferencesHelper().getUserDisplayName().then((value) {
      setState(
        () {
          myname = value ?? '';
        },
      );
    });
    SharedPreferencesHelper().getUserMail().then((value) {
      setState(
        () {
          myEmail = value ?? '';
        },
      );
    });
    SharedPreferencesHelper().getUserPic().then((value) {
      setState(
        () {
          myProfilePic = value ?? '';
        },
      );
    });
    SharedPreferencesHelper().getUserName().then((value) {
      setState(
        () {
          myuserName = value ?? '';
        },
      );
    });
    chatStream =
        await FirebaseMethods().getUsrChat(); //return all chats of this user
    x = await FirebaseMethods().getUsrChat();

    print(x);

    setState(() {});
  }

  Widget ChatroomList() {
    return StreamBuilder(
        stream: chatStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  DocumentSnapshot ds = snapshot.data.docs[i];
                  String chatedUsername = ds['users'][0];
                  if (ds['users'][0] == myuserName) {
                    chatedUsername = ds['users'][1];
                  }
                  return ChatRoomListTilState(
                    username: chatedUsername,
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  @override
  void initState() {
    super.initState();

    // Assuming SharedPreferencesHelper().getUserDisplayName() returns a Future<String>

    ontheLoad();
    setState(() {});
  }

  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(String value) {
    setState(() {
      search = true;
    });
    if (value.isEmpty) {
      setState(
        () {
          //handle if user was not empty and become empty  //os => o =>
          queryResultSet = [];
          tempSearchStore = [];
        },
      );
    }
    if (queryResultSet.isEmpty && value.isNotEmpty) {
      FirebaseMethods().searchByKey(value).then(
        (QuerySnapshot q) {
          for (int i = 0; i < q.docs.length; i++) {
            queryResultSet.add(q.docs[i].data());
          } //{osos111, osman111, obama111} are elements in queryresultset
          //all elements thats start with o
        },
      );
      setState(() {});
    } else {
      tempSearchStore = [];
      for (var element in queryResultSet) {
          if (element['username'].startsWith(value)) {
            setState(
              () {
                tempSearchStore.add(element);
              },
            );
          }
        }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: Colors.blueGrey,
            child: Row(
              children: [
                IconButton(
                  //*************exit icon**************

                  onPressed: () {
                    HelperFunctions().showLogoutDialog(context);
                  },
                  icon: const Icon(Icons.exit_to_app),
                  color: kWhite,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 1, right: 2),
                    child: search
                        ? IconButton(
                            //*************close icon**************
                            onPressed: () {
                              queryResultSet = [];
                              tempSearchStore = [];
                              search = false;

                              setState(() {});
                            },
                            icon: const Icon(Icons.close),
                            color: kWhite,
                            iconSize: 30,
                          )
                        : IconButton(
                            //*************search icon**************
                            onPressed: () {
                              search = true;
                              setState(() {});
                            },
                            icon: const Icon(Icons.search),
                            color: kWhite,
                            iconSize: 30,
                          )),
                const Spacer(),
                search
                    ? Expanded(
                        //************* search textfiled **************
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SearchText(
                            onChanged: (value) {
                              initiateSearch(value
                                  .toUpperCase()); //get all usernames statrs with input
                            },
                          ),
                        ),
                      )
                    : Padding(
                        //************* name of curent user **************
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          myname,
                          style: TextStyle(fontSize: 24, color: kWhite),
                        ),
                      )
              ],
            ),
          ),
          //

          //
          search
              ? ListView(
                  // ****************** list of searched users ************
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  primary: false,
                  shrinkWrap: true,
                  children: tempSearchStore.map((e) {
                    return ResultWdget(
                      data: e,
                      ontap: () async {
                        search = false;
                        queryResultSet = [];
                        tempSearchStore = [];

                        var chatroomId = //id based on two names
                            HelperFunctions().getchatroomIdbyUsersname(
                                myuserName, e['username']);
                        Map<String, dynamic> chatRoomInfo = {
                          'users': [myuserName, e['username']],
                        };
                        await FirebaseMethods()
                            .createChatRoom(chatroomId, chatRoomInfo);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ChatPage(
                                email: e['email'],
                                name: e['name'],
                                profilePic: e['image'],
                                username: e['username'],
                                senderUsername: myuserName,
                              );
                            },
                          ),
                        );
                        HelperFunctions().getChats(myuserName);
                        setState(() {});
                      },
                    );
                  }).toList(),
                )
              : ChatroomList()
          // : ListView(
          //     // ****************** list of chats ***************
          //     padding: EdgeInsets.only(left: 10, right: 10),
          //     primary: false,
          //     shrinkWrap: true,
          //     children: HelperFunctions().usersCurrentChats.map((e) {
          //       return resultWdget(
          //         data: e,
          //         ontap: () async {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) {
          //                 return ChatPage(
          //                   email: e['email'],
          //                   name: e['name'],
          //                   profilePic: e['image'],
          //                   username: e['username'],
          //                   senderUsername: myuserName,
          //                 );
          //               },
          //             ),
          //           );

          //           setState(() {});
          //         },
          //       );
          //     }).toList(),
          //   )

          // : Column(
          //     // ****************** list of users chats ************
          //     children: [

          //     ],
          //   ),
        ],
      ),
    );
  }
}














/*
 
           Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
              child: ListTile(
                leading: CircleAvatar(
                  minRadius: 50,
                  maxRadius: 100,
                  backgroundImage: AssetImage('images/haz4.jpg'),
                ),
                title: Text('user 2'),
              ),
            ) 
        
*/
