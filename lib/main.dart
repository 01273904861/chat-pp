import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:my_chat_2/screens/forget_password.dart';
import 'package:my_chat_2/screens/home_page.dart';
import 'package:my_chat_2/screens/log_in_page.dart';
import 'package:my_chat_2/screens/sign_up_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyChat());
}

class MyChat extends StatelessWidget {
  const MyChat({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SignUpPage.id: (context) => const SignUpPage(),
        LogInPage.id: (context) => const LogInPage(),
        HomePage.id: (context) => const HomePage(),
        ForgetPassword.id: (context) => const ForgetPassword(),
      },
      debugShowCheckedModeBanner: false,
      title: 'chat application',
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? LogInPage.id
          : HomePage.id,
    );
  }
}
