import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polimer/features/signup/bloc/signup_bloc_bloc.dart';

Widget myTextfield(
    {required TextEditingController controller,
    required String labelText,
    required BuildContext context,
    bool isUsernameFiled = false,
    String? usernameErrorText,
    bool isLoading = false}) {
  return Padding(
    padding: const EdgeInsets.all(14.0),
    child: Focus(
      onFocusChange: (value) {
        if (isUsernameFiled) {
          if (!value) {
            context
                .read<SignupBlocBloc>()
                .add(usernamefieldUnfocusEvent(controller.text));
          }
        }
      },
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (text) {
          if (text!.length < 8) {
            return "Must have 8 charecters";
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
          suffix: isLoading
              ? Container(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ))
              : null,
          errorText: isUsernameFiled ? usernameErrorText : null,
          labelText: labelText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.8,
              color: Color.fromARGB(255, 255, 111, 0),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.8,
              color: Color.fromARGB(255, 255, 111, 0),
            ),
          ),
        ),
      ),
    ),
  );
}
