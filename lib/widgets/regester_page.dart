import 'package:chat_app/Cubits/auth_cubit.dart';
import 'package:chat_app/widgets/costum_text_field.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:chat_app/chat_page.dart';





class regesterpageState extends StatelessWidget {
   String? email;
static String id='_regesterpageState';
   String? password;

   bool isloading=false;

   GlobalKey<FormState>formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
      if (state is RegesterLoading) {
        isloading == true;
      } else if (state is RegesterSuccess) {
        Navigator.pushNamed(context, ChatPage.id);
        isloading==false;
      } else if (state is RegesterFailure) {
        showSnackBar(context, state.errorMessage);
        isloading==false;
      }
    },
    builder: (context,state) =>ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: KPrimaryColor,

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(height: 75,),

                Image.asset('assets/images/scholar.png',height: 100,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(height: 75,),
                    Text('Scholar Chat',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico'


                    ),),
                  ],
                ),

                SizedBox(height: 75,),
                Row(
                  children: [
                    Text('REGESTER',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white70




                    ),),
                  ],
                ),

                const SizedBox(
                  height: 15,
                ),//just like the container but better
                customTextFormField(
                  hinttext:'Email' ,
                  onChanged:(data){

                    email=data;
                  } ,


                ),
                const SizedBox(height: 20,),

                customTextFormField(
                  onChanged: (data){
                    password=data;

                  },

                  hinttext:'password' ,


                ),
                const SizedBox(height: 10,),
                custombutton(
                  text: 'Regester',
                  onTap: ()async {
                    if (formKey.currentState!.validate()) {


                          BlocProvider.of<AuthCubit>(context)
                              .regesterUser(email: email!, password: password!);


                    }
                  }
                ),

                //sign up
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('already have an account? ' ,style: TextStyle(
                      color: Colors.white70,

                    ),),
                    SizedBox(height: 75,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, loginpageState.id);

                      },


                      child: Text(' sign in ' ,style: TextStyle(
                        color: Color(0xffC7EDE6),

                      ),),
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
   void showSnackBar(BuildContext context,String message){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       content: Text(message),),);

   }

   Future<void>regesterUser()async{

     UserCredential user=await
     FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: email!, password: password!
     );
   }

}
