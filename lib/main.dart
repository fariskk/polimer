import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:polimer/features/home_screen/precentation/screens/homeScreen.dart';
import 'package:polimer/features/profilepicture_selection/bloc/profilepicture_bloc_bloc.dart';
import 'package:polimer/features/profilepicture_selection/precentation/screens/profilepicture_selection.dart';
import 'package:polimer/features/signin/bloc/login_bloc_bloc.dart';
import 'package:polimer/features/signin/precentation/screens/signin_screen.dart';
import 'package:polimer/features/signup/bloc/signup_bloc_bloc.dart';
import 'package:polimer/features/signup/precentation/screens/signup_screen.dart';
import 'package:polimer/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBlocBloc(),
        ),
        BlocProvider(
          create: (context) => SignupBlocBloc(),
        ),
        BlocProvider(
          create: (context) => ProfilepictureBlocBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (FirebaseAuth.instance.currentUser!.photoURL == null) {
                return ProfilepictureSlectionScreen(
                    floatinactionButtonOnpressed: () {});
              }
              return HomeScreen();
            } else {
              return SigninScreen();
            }
          },
        ),
      ),
    );
  }
}
