import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'newchat_bloc_event.dart';
part 'newchat_bloc_state.dart';

class NewchatBlocBloc extends Bloc<NewchatBlocEvent, NewchatBlocState> {
  NewchatBlocBloc() : super(NewchatBlocInitial()) {
    on<NewchatBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
