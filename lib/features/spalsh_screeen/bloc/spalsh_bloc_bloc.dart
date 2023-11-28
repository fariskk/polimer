import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'spalsh_bloc_event.dart';
part 'spalsh_bloc_state.dart';

class SpalshBlocBloc extends Bloc<SpalshBlocEvent, SpalshBlocState> {
  SpalshBlocBloc() : super(SpalshBlocInitial()) {
    on<SpalshBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
