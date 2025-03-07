import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_chat_2/constants.dart';
import 'package:my_chat_2/models/user_model.dart';
import 'package:my_chat_2/services/shared_prefernces_helper.dart';

class FirebaseMethods {
  Future<UserModel> getCurrentUser(String id) async {
    var userData = await usersCollection.doc(id).get();
    return UserModel.from(userData);
  }


  Future getAllUsers() async {
    var usersData = await usersCollection.get();
    return usersData.docs;
  }

  Future addUser(Map<String, dynamic> user, String id) async {
    return await usersCollection.doc(id).set(user);
  }

  Future<QuerySnapshot> getUserDataByEmail(String email) async {
    QuerySnapshot querySnapshot = //return a value or values
        await usersCollection.where('email', isEqualTo: email).get();
    return querySnapshot;
  }

  Future<QuerySnapshot> getUserDataByUsername(String username) async {
    QuerySnapshot querySnapshot = //return a value or values
        await usersCollection.where('username', isEqualTo: username).get();
    return querySnapshot;
  }
  // Future<QuerySnapshot> getValuesGT4(int x) async{
  //   QuerySnapshot k = await usersCollection.where(x ,isGreaterThan: 4).get();
  //   return k;
  // }

  Future<QuerySnapshot> searchByKey(String string) async {
    return await usersCollection //return all users that starts with the same character
        .where('searchKey', isEqualTo: string.substring(0, 1).toUpperCase())
        .get();
  }

  createChatRoom(String chatRoomId, Map<String, dynamic> chatRoomInfo) async {
    final chatroom = await chatrooms.doc(chatRoomId).get();
    if (!chatroom.exists) {
      chatrooms.doc(chatRoomId).set(chatRoomInfo);
    }
  }
//  addmessage(String chatroomId ,Map<String ,dynamic> messageInfo ){
//    chatrooms.doc(chatroomId).collection(kMessages).doc().set(messageInfo);
//  }

  Future<List> getChatedUsers(String username) async {
    List chatedUsers = [];
    QuerySnapshot q =
        await chatrooms.get(); //get all chat rooms "get the collection"
    for (QueryDocumentSnapshot chatroom in q.docs) {
      if (chatroom['users'][0] == username) {
        //if the sender is me ??
        chatedUsers
            .add(chatroom['users'][1]); //get another person who i chat with him
      }
      if (chatroom['users'][1] == username) {
        //if the sender is me ??
        chatedUsers.add(chatroom['users'][0]);
      }
    }
    return chatedUsers;
  }

  Future<Stream<QuerySnapshot>> getUsrChat() async {
    String? username = await SharedPreferencesHelper().getUserName();
    return chatrooms
        .where('users', arrayContains: username?.toUpperCase())
        .snapshots();
  }
}
