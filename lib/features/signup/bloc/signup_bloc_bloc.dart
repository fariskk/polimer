import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signup_bloc_event.dart';
part 'signup_bloc_state.dart';

class SignupBlocBloc extends Bloc<SignupBlocEvent, SignupBlocState> {
  SignupBlocBloc() : super(SignupBlocInitial()) {
    on<usernamefieldUnfocusEvent>((event, emit) async {
      emit(UsernameCheckingstate());
      final fir = FirebaseFirestore.instance.collection("users");
      final data = await fir.doc(event.userName).get();

      if (data.data() != null) {
        emit(UserNameNotAvailableStete("Username Already used"));
      } else {
        emit(userNameAvailableStete());
      }
    });
    on<FloatingActionButtonClickedEvent>((event, emit) async {
      if (event.password == event.conformPassword) {
        emit(LoadingState());
        final fir = FirebaseFirestore.instance.collection("users");
        final data = await fir.doc(event.userName).get();

        if (data.data() != null) {
          emit(UserNameNotAvailableStete("Username Already used"));
        } else {
          try {
            await fir
                .doc(event.userName)
                .set({"username": event.userName, "passwor": event.password});
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: "${event.userName}@gmail.com",
                password: "${event.password}");
            await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: "${event.userName}@gmail.com",
                password: "${event.password}");
            emit(SignupSuccessState());
          } catch (e) {
            emit(SignupFaildState());
          }
        }
      } else {
        emit(PasswordDonotMatchError());
      }
    });
  }
}
