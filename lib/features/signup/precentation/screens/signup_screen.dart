import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polimer/features/profilepicture_selection/precentation/screens/profilepicture_selection.dart';
import 'package:polimer/features/signin/precentation/screens/signin_screen.dart';
import 'package:polimer/features/signup/bloc/signup_bloc_bloc.dart';
import 'package:polimer/features/signup/precentation/widgets/signup_widgets.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _conformPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBlocBloc, SignupBlocState>(
      listener: (context, state) {
        if (state is SignupSuccessState) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        floatingActionButton: BlocBuilder<SignupBlocBloc, SignupBlocState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 255, 111, 0),
                shape: const CircleBorder(),
                onPressed: () {},
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              );
            }
            return FloatingActionButton(
              onPressed: () {},
              backgroundColor: Color.fromARGB(255, 255, 111, 0),
              shape: const CircleBorder(),
              child: IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  context.read<SignupBlocBloc>().add(
                      FloatingActionButtonClickedEvent(
                          _usernameController.text,
                          _passwordController.text,
                          _conformPasswordController.text));
                },
              ),
            );
          },
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.1,
                  child: Center(
                    child: Icon(
                      Icons.flutter_dash,
                      size: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<SignupBlocBloc, SignupBlocState>(
                      builder: (context, state) {
                        if (state is UsernameCheckingstate) {
                          return myTextfield(
                              controller: _usernameController,
                              labelText: "username",
                              context: context,
                              isUsernameFiled: true,
                              isLoading: true);
                        }
                        if (state is UserNameNotAvailableStete) {
                          return myTextfield(
                              controller: _usernameController,
                              labelText: "username",
                              context: context,
                              isUsernameFiled: true,
                              usernameErrorText: state.message);
                        }
                        return myTextfield(
                            controller: _usernameController,
                            labelText: "username",
                            context: context,
                            isUsernameFiled: true);
                      },
                    ),
                    myTextfield(
                      controller: _passwordController,
                      labelText: "password",
                      context: context,
                    ),
                    myTextfield(
                      controller: _conformPasswordController,
                      labelText: "conform Password",
                      context: context,
                    ),
                    BlocBuilder<SignupBlocBloc, SignupBlocState>(
                      builder: (context, state) {
                        if (state is PasswordDonotMatchError) {
                          return Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "    Password Donot Match",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 209, 78, 76),
                                  fontSize: 12,
                                ),
                              ));
                        }
                        return SizedBox();
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have a account "),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Text(
                            "Sign in",
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
