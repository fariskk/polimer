import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'language_bloc_event.dart';
part 'language_bloc_state.dart';

class LanguageBlocBloc extends Bloc<LanguageBlocEvent, LanguageBlocState> {
  LanguageBlocBloc() : super(LanguageBlocInitial()) {
    on<LanguageBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
