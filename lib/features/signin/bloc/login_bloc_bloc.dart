import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBlocBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBlocBloc() : super(LoginBlocInitial()) {
    on<FloatingActionButtonClickedEvent>((event, emit) async {
      try {
        emit(LoadingState());
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: "${event.username}@gmail.com", password: event.password);
        emit(SigninSuccessState());
      } catch (e) {
        emit(SigninFaildState("Invalied Username or Password"));
      }
    });
  }
}
