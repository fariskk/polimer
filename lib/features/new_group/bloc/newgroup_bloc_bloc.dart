import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'newgroup_bloc_event.dart';
part 'newgroup_bloc_state.dart';

class NewgroupBlocBloc extends Bloc<NewgroupBlocEvent, NewgroupBlocState> {
  NewgroupBlocBloc() : super(NewgroupBlocInitial()) {
    on<NewgroupBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
