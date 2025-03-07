import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_chat_2/constants.dart';
import 'package:my_chat_2/functions/helper_functions.dart';
import 'package:my_chat_2/screens/log_in_page.dart';
import 'package:my_chat_2/screens/sign_up_page.dart';
import 'package:my_chat_2/widgets/custom_button.dart';
import 'package:my_chat_2/widgets/custom_text_filed.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});
  static String id = 'forget_password';
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

final GlobalKey<FormState> formKey = GlobalKey();
TextEditingController emailController = TextEditingController();
String? email;
bool isLoading = false;

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(height: 40),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/Mobile login-rafiki.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'reset password',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    textEditingController: emailController,
                    hinText: 'email',
                    onChanged: (value) {
                      email = value;
                    },
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      isLoading = true;
                      setState(() {});
                      if (formKey.currentState!.validate()) {
                        await resetPassword();
                        isLoading = false;
                        setState(() {});
                      }
                    },
                    child: CustomButton(buttonName: 'SEND EMAIL'),
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

  Future<void> resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
      HelperFunctions()
          .scaffoldMessengerMassage('email is sent succesfully',BuildContext );

      emailController.clear();
      Navigator.of(context).pushReplacementNamed(LogInPage.id);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        HelperFunctions()
            .scaffoldMessengerMassage('No user found for that email.', BuildContext);
      } else {
        HelperFunctions().scaffoldMessengerMassage('check email ', BuildContext);
      }
    } catch (e) {
      HelperFunctions().scaffoldMessengerMassage(e.toString(), BuildContext);
    }
  }
}
