import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'accountscreen_bloc_event.dart';
part 'accountscreen_bloc_state.dart';

class AccountscreenBlocBloc extends Bloc<AccountscreenBlocEvent, AccountscreenBlocState> {
  AccountscreenBlocBloc() : super(AccountscreenBlocInitial()) {
    on<AccountscreenBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
