import 'package:flutter/material.dart';
import 'package:polimer/features/signin/precentation/screens/signin_screen.dart';
import 'package:polimer/features/signup/precentation/widgets/signup_widgets.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _conformPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color.fromARGB(255, 255, 111, 0),
        shape: const CircleBorder(),
        child: IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () {},
        ),
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
                  myTextfield(_conformPasswordController, "conform Password"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have a account "),
                      GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SigninScreen(),
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
