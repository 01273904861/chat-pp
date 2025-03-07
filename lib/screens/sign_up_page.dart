import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_chat_2/constants.dart';
import 'package:my_chat_2/functions/helper_functions.dart';
import 'package:my_chat_2/screens/home_page.dart';
import 'package:my_chat_2/screens/log_in_page.dart';
import 'package:my_chat_2/services/firebase_methods.dart';
import 'package:my_chat_2/services/shared_prefernces_helper.dart';
import 'package:my_chat_2/widgets/custom_button.dart';
import 'package:my_chat_2/widgets/custom_text_filed.dart';
import 'package:random_string/random_string.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static String id = 'sign up';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? name, email, number, password, confirmPass;

  final GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPagesColor,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Column(
                children: [
                 const SizedBox(height: 18),
                  const Text(
                    'Let\'s Get Started !',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                const  Text('create your own account',
                      style: TextStyle(color: Colors.blueGrey)),
                  const SizedBox(height: 18),
                  CustomTextField(
                    hinText: 'your name',
                    icon: Icons.person,
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  CustomTextField(
                    hinText: 'email',
                    icon: Icons.email,
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  CustomTextField(
                    hinText: 'phone',
                    icon: Icons.phone,
                    onChanged: (value) {
                      number = value;
                    },
                  ),
                  CustomTextField(
                    hinText: 'password',
                    icon: Icons.lock_open,
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  CustomTextField(
                    hinText: 'confirm password',
                    icon: Icons.lock_open,
                    onChanged: (value) {
                      confirmPass = value;
                    },
                  ),
               const   SizedBox(height: 18),

                  ///button for sign up
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            await creatUser();
                            // String username =
                            //     email!.replaceAll('@gmail.com', '');
                           
                           
                            Navigator.of(context).pushNamed(HomePage.id);
                            isLoading = false;
                            setState(() {});
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              HelperFunctions().scaffoldMessengerMassage(
                                  'The password provided is too weak.',
                                  context);
                            } else if (e.code == 'email-already-in-use') {
                              HelperFunctions().scaffoldMessengerMassage(
                                  'The account already exists for that email.',
                                  context);
                            }
                            isLoading = false;
                            setState(() {});
                          } catch (e) {
                            HelperFunctions().scaffoldMessengerMassage(
                                e.toString(), context);
                            isLoading = false;
                            setState(() {});
                          }
                        }
                      },
                      child: CustomButton(
                        buttonName: 'CREATE',
                      ),
                    ),
                  ),
                const  SizedBox(height: 18),

                  ///text for log in
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                   const   Text(
                        'already have an account? ',
                        style: TextStyle(fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, LogInPage.id);
                        },
                        child:const Text(
                          'login here ',
                          style: TextStyle(fontSize: 18, color: kPrimaryColor),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> creatUser() async {
    if (password == confirmPass) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      String userName = email!.replaceAll('@gmail.com', '');
      String updateUserName =
          userName.replaceFirst(userName[0], userName[0].toUpperCase());
      String firstLetter = updateUserName.substring(0, 1);
      String id = randomAlphaNumeric(8);
       HelperFunctions().getChats(userName);
      HelperFunctions().scaffoldMessengerMassage('hello $name' , context);
      Map<String, dynamic> user = {
        'name': name!,
        'number': number!,
        'email': email!,
        'id': id,
        'searchKey': firstLetter,
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/d/d7/Cristiano_Ronaldo_playing_for_Al_Nassr_FC_against_Persepolis%2C_September_2023_%28cropped%29.jpg',
        'username': updateUserName.toUpperCase(),
      };

      await FirebaseMethods().addUser(user, id);
      await SharedPreferencesHelper().saveUserId(id);
      await SharedPreferencesHelper().saveUserEmail(email!);
      await SharedPreferencesHelper().saveUserName(userName);
      await SharedPreferencesHelper().saveUserPic(
          'https://upload.wikimedia.org/wikipedia/commons/d/d7/Cristiano_Ronaldo_playing_for_Al_Nassr_FC_against_Persepolis%2C_September_2023_%28cropped%29.jpg');
      await SharedPreferencesHelper().saveUserDisplayName(name!);
    } else {
      throw ('password not equal confirm password');
    }
  }
}
//abdo111@gmail.com
//abdo 
//12345
//012345

//mohamed111@gmail.com 
//123456
//0123456

//karim111@gmail.com
//12345
//012345

//ossama111@gmail.com
//123456
//012345678

//ali111@gmail.com
//0123456789
//123456


/*
osman111@gmail.com
123456
01234555

osos111@gmail.com
123456
01234566

ahmed111@gmail.com
123456
*/


//obama111@gmail.com
//123456
//012345677