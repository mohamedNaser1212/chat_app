

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async{
     if(event is LoginEvents){
       emit(LoginLoading());
       try {
         UserCredential user =
             await FirebaseAuth.instance.signInWithEmailAndPassword(
           email: event.email,
           password: event.password,
         );
         emit(LoginSuccess());
       } on FirebaseAuthException catch (eX) {
         if (eX.code == 'user-not-found') {
           emit(LoginFailure( errorMessage: 'user-not-found'));
         } else if (eX.code == 'wrong-password') {
           emit(LoginFailure(errorMessage: 'wrong-password'));
         }
       }



       on Exception catch (e) {
         emit(LoginFailure(errorMessage: 'Something went wrong'));
       }


     }
    });
  }
  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
    print(transition);
  }
}
