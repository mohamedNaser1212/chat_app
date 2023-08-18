import 'package:chat_app/Cubits/chat_cubit.dart';
import 'package:chat_app/blocs/auth_bloc.dart';
import 'package:chat_app/chat_page.dart';
import 'package:chat_app/widgets/costum_text_field.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/regester_page.dart';

import 'package:flutter/material.dart';
import 'package:chat_app/constant.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snack_bar.dart';

class loginpageState extends StatelessWidget {
  String? email;
  static String id = 'loginpage';

  String? password;

  bool isloading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isloading == true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
         
          Navigator.pushNamedAndRemoveUntil(context,  ChatPage.id, arguments: email, (route) => false);
          isloading == false;
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errorMessage);
          isloading == false;
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isloading,
        child: Scaffold(
          backgroundColor: KPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 75,
                  ),

                  Image.asset(
                    'assets/images/scholar.png',
                    height: 100,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 75,
                      ),
                      Text(
                        'Scholar Chat',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: Colors.white,
                            fontFamily: 'pacifico'),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 75,
                  ),
                  const Row(
                    children: [
                      Text(
                        'sign in ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white70),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ), //just like the container but better
                  customTextFormField(
                    hinttext: 'Email',
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  customTextFormField(
                    obscureText: true,
                    onChanged: (data) {
                      password = data;
                    },
                    hinttext: 'password',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  custombutton(
                      text: 'Sign in',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(LoginEvents(
                              email: email!, password: password!));

                        }
                      }),
                  //sign up
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'dont have an account? ',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(
                        height: 75,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(context, regesterpageState.id);
                          Navigator.pushNamedAndRemoveUntil(context, regesterpageState.id, (route) => false);
                        },
                        child: const Text(
                          ' Regester ',
                          style: TextStyle(
                            color: Color(0xffC7EDE6),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
