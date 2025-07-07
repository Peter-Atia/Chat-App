import 'package:chat_app/cubits/register_cubit/register_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  Future<void> registerUser(context,
      {required email, required password}) async {
    emit(RegisterLoadingState());
    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(RegisterFailureState(
            errorMessage: "The account already exists for that email."));
      }
    } catch (e) {
      emit(RegisterFailureState(errorMessage: e.toString()));
    }
  }
}
