abstract class LogInStates {}

class LogInInitialState extends LogInStates {}

class LogInSuccessState extends LogInStates {}

class LogInLoadingState extends LogInStates {}

class LogInFailureState extends LogInStates {
  String errorMessage;
  LogInFailureState({required this.errorMessage});
}
