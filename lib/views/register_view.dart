import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/register_cubit/register_cubit.dart';
import 'package:chat_app/cubits/register_cubit/register_states.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/show_snackBar.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static String id = "RegisterView";

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) => {
          if (state is RegisterLoadingState)
            {
              isLoading = true,
            }
          else if (state is RegisterSuccessState)
            {
              Navigator.pushNamed(context, ChatView.id, arguments: email),
              isLoading = false,
            }
          else if (state is RegisterFailureState)
            {
              isLoading = false,
              showSnackBar(context, state.errorMessage),
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
                          "Register",
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
                        }),
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
                          BlocProvider.of<RegisterCubit>(context).registerUser(
                              context,
                              email: email,
                              password: password);
                        }
                      },
                      text: "Register",
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account ? ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Log In ",
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
