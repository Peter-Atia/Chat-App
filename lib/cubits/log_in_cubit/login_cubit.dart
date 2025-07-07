import 'package:chat_app/cubits/log_in_cubit/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInCubit extends Cubit<LogInStates> {
  LogInCubit() : super(LogInInitialState());

  Future<void> signInUser(context, {required email, required password}) async {
    emit(LogInLoadingState());
    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LogInSuccessState());
    }
    on FirebaseAuthException catch (e) {
      emit(LogInFailureState(errorMessage: e.code));
    }
    catch (e) {
      emit(LogInFailureState(errorMessage: e.toString()));
    }
  }
}
