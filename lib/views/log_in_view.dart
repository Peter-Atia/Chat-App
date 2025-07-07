import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/log_in_cubit/login_cubit.dart';
import 'package:chat_app/cubits/log_in_cubit/login_states.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/register_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/show_snackBar.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});
  static String id = "LogInView";

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  String? email;

  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LogInCubit>(
      create: (BuildContext context) =>LogInCubit(),
      child: BlocConsumer<LogInCubit, LogInStates>(
        listener: (context, state) {
          if (state is LogInLoadingState) {
            isLoading = true;
          } else if (state is LogInSuccessState) {
            isLoading=false;
            Navigator.pushNamed(context, ChatView.id,arguments: email);
          } else if (state is LogInFailureState) {
            isLoading=false;
            showSnackBar(context, state.errorMessage);
          }
        },
        builder: (context, state) => ModalProgressHUD(
          inAsyncCall: isLoading,
          color: Colors.white,
          blur: 1,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    Image.asset(kLogo),
                    const Text(
                      "Scholar Chat",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Log In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    CustomTextFormField(
                      hintText: "Email",
                      onChanged: (data) {
                        email = data;
                      },
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      hintText: "Password",
                      onChanged: (data) {
                        password = data;
                      },
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<LogInCubit>(context).signInUser(context,
                              email: email, password: password);
                        }
                      },
                      text: "Log In",
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account ? ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterView.id);
                          },
                          child: const Text(
                            "Register ",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Color(0xffc7ede6),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
