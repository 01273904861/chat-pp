import 'package:shared_preferences/shared_preferences.dart';

/*
This means that the data you store can be
 accessed and modified by different parts of your app.
 Persistence: The data you save will remain even after 
 the app is closed or the device is restarted. 
 This is known as persistent storage.
Key-value pairs: You store data in the 
form of keys (unique identifiers) and their corresponding values.
 For example, you might have a key "username" with the value "John".
 */
class SharedPreferencesHelper {
  static String userIdKey = 'USERKEY';
  static String userNameKey = 'USERNAMEKEY';
  static String userEmailKey = 'USEREMAILKEY';
  static String userPicKey = 'USERPICKEY';
  static String userDisplayname = 'USERDISPLAYNAME';
  static String usersChatsKey = 'USERSCHATSKEY';

//save methods
//SharedPreferences.getInstance() method returns a Future<SharedPreferences>
  Future<bool> saveUserId(String userId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userIdKey, userId);
  }

  Future<bool> saveUserName(String getUserName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userNameKey, getUserName);
    // username : ali
  }

  Future<bool> saveUserEmail(String getUserEmail) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userEmailKey, getUserEmail);
  }

  Future<bool> saveUserPic(String getUserPic) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userIdKey, getUserPic);
  }

  Future<bool> saveUserDisplayName(String getUserDisplayName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userDisplayname, getUserDisplayName);
  }

  //****************************get methods


  Future<String?> getUserId() async {
    //take 2 sec
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userIdKey);
  }

  Future<String?> getUserMail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userEmailKey);
  }

  Future<String?> getUserName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userNameKey);
    // username : 'ali'
  }

  Future<String?> getUserPic() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userPicKey);
  }

  Future<String?> getUserDisplayName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userDisplayname);
  }
}
