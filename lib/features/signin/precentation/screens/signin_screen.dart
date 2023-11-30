import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polimer/features/signin/bloc/login_bloc_bloc.dart';
import 'package:polimer/features/signup/precentation/screens/signup_screen.dart';
import 'package:polimer/features/signin/precentation/widgets/signin_widgets.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocBuilder<LoginBlocBloc, LoginBlocState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return FloatingActionButton(
              onPressed: () {},
              backgroundColor: Color.fromARGB(255, 255, 111, 0),
              shape: const CircleBorder(),
              child: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            );
          }
          return FloatingActionButton(
              onPressed: () {
                context.read<LoginBlocBloc>().add(
                    FloatingActionButtonClickedEvent(
                        _usernameController.text, _passwordController.text));
              },
              backgroundColor: Color.fromARGB(255, 255, 111, 0),
              shape: const CircleBorder(),
              child: Icon(Icons.arrow_forward));
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
                  myTextfield(_usernameController, "Username"),
                  myTextfield(_passwordController, "password"),
                  BlocBuilder<LoginBlocBloc, LoginBlocState>(
                    builder: (context, state) {
                      if (state is SigninFaildState) {
                        return Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, bottom: 20),
                              child: Text(
                                state.errorMessage,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 209, 78, 76),
                                  fontSize: 12,
                                ),
                              ),
                            ));
                      }
                      return Container();
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Dont have an acccount "),
                      GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        )),
                        child: const Text(
                          "Sign up",
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
    );
  }
}
