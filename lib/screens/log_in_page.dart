import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_chat_2/constants.dart';
import 'package:my_chat_2/functions/helper_functions.dart';
import 'package:my_chat_2/screens/forget_password.dart';
import 'package:my_chat_2/screens/home_page.dart';
import 'package:my_chat_2/screens/sign_up_page.dart';
import 'package:my_chat_2/services/firebase_methods.dart';
import 'package:my_chat_2/services/shared_prefernces_helper.dart';
import 'package:my_chat_2/widgets/custom_button.dart';
import 'package:my_chat_2/widgets/custom_text_filed.dart';

class LogInPage extends StatefulWidget {
  static String id = 'log_in';

  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String? email, password;

  final GlobalKey<FormState> formKey = GlobalKey();
  bool isLoding = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoding,
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Column(
                children: [
                const  SizedBox(height: 30),
                  Container(
                    width: 200,
                    height: 200,
                    decoration:const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/Mobile login-rafiki.png'),
                      ),
                    ),
                  ),
              const    SizedBox(height: 15),
                 const Text(
                    'Welcome back!',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                 const Text(
                    'log in to your account',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                const  SizedBox(
                    height: 7,
                  ),
                  CustomTextField(
                    hinText: 'email',
                    onChanged: (value) {
                      email = value;
                    },
                    icon: Icons.email,
                  ),
              const    SizedBox(height: 7),
                  CustomTextField(
                    hinText: 'password',
                    icon: Icons.lock_open,
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(ForgetPassword.id);
                        },
                        child: const Text(
                          'forget password ?    ',
                          style:
                              TextStyle(fontSize: 17, color: Colors.blueGrey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoding = true;
                        setState(() {});
                        try {
                          await SignIn();
                          String username = email!.replaceAll('@gmail.com', '');
                          HelperFunctions().getChats(username);
                          HelperFunctions()
                              .scaffoldMessengerMassage('sucess', BuildContext);
                          Navigator.of( context)
                              .pushReplacementNamed(HomePage.id);
                          isLoding = false;
                          setState(() {});
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            HelperFunctions().scaffoldMessengerMassage(
                                'No user found for that email.', BuildContext);
                          } else if (e.code == 'wrong-password') {
                            HelperFunctions().scaffoldMessengerMassage(
                                'Wrong password provided for that user.',
                                BuildContext);
                          } else {
                            HelperFunctions().scaffoldMessengerMassage(
                                'check email and password', BuildContext);
                          }
                          isLoding = false;
                          setState(() {});
                        } catch (e) {
                          HelperFunctions()
                              .scaffoldMessengerMassage(e.toString(), BuildContext);
                          isLoding = false;
                          setState(() {});
                        }
                      }
                    },
                    child:const CustomButton(buttonName: 'LOG IN'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t  have an account?',
                        style: TextStyle(fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(SignUpPage.id);
                        },
                        child: const Text(
                          'sign up',
                          style: TextStyle(fontSize: 18, color: kPrimaryColor),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> SignIn() async {
    final UserCredential credential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    QuerySnapshot querySnapshot =
        await FirebaseMethods().getUserDataByEmail(email!);
    //retrieves data from a Firestore query result,
    // then saves that data locally using shared preferences,
    //which can be accessed and used by the Flutter application
    // across different app sessions.
    String name = querySnapshot.docs[0]['name'];
    String image = querySnapshot.docs[0]['image'];
    String username = querySnapshot.docs[0]['username'];
    String id = querySnapshot.docs[0]['id'];
    await SharedPreferencesHelper().saveUserDisplayName(name);
    await SharedPreferencesHelper().saveUserEmail(email!);
    await SharedPreferencesHelper().saveUserId(id);
    await SharedPreferencesHelper().saveUserPic(image);
    await SharedPreferencesHelper().saveUserName(username);
    HelperFunctions().scaffoldMessengerMassage('hello $name' , BuildContext);
  }
}
