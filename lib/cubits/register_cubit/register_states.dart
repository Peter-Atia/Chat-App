abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterFailureState extends RegisterStates {
  RegisterFailureState({required this.errorMessage});
  String errorMessage;
}
