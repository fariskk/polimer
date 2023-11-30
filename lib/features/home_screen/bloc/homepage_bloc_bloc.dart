import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'homepage_bloc_event.dart';
part 'homepage_bloc_state.dart';

class HomepageBlocBloc extends Bloc<HomepageBlocEvent, HomepageBlocState> {
  HomepageBlocBloc() : super(HomepageBlocInitial()) {
    on<HomepageBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
