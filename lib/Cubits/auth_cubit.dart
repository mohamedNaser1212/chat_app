import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> loginUser(
      {required String email, required String password}) async {
    // emit(LoginLoading());
    // try {
    //   UserCredential user =
    //   await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: email,
    //     password: password,
    //   );
    //   emit(LoginSuccess());
    // } on FirebaseAuthException catch (eX) {
    //   if (eX.code == 'user-not-found') {
    //     emit(LoginFailure( errorMessage: 'user-not-found'));
    //   } else if (eX.code == 'wrong-password') {
    //     emit(LoginFailure(errorMessage: 'wrong-password'));
    //   }
    // }
    //
    //
    //
    // on Exception catch (e) {
    //   emit(LoginFailure(errorMessage: 'Something went wrong'));
    // }


  }
  Future<void> regesterUser(
      {required String email, required String password}) async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    emit(RegesterLoading());
    try {
      UserCredential user =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegesterSuccess());
    } on FirebaseAuthException catch (eX) {
      if (eX.code == 'weak-password') {
        emit(RegesterFailure(errorMessage: 'weak-password'));
      } else if (eX.code == 'email-already-in-use') {
        emit(RegesterFailure(errorMessage: 'email-already-in-use'));
      }
    } on Exception catch (e) {
      emit(RegesterFailure(errorMessage: 'Something went wrong,please try again'));
    }
  }
  @override
  void onChange(Change<AuthState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }
}

