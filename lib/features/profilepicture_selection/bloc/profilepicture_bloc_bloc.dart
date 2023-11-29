import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profilepicture_bloc_event.dart';
part 'profilepicture_bloc_state.dart';

class ProfilepictureBlocBloc extends Bloc<ProfilepictureBlocEvent, ProfilepictureBlocState> {
  ProfilepictureBlocBloc() : super(ProfilepictureBlocInitial()) {
    on<ProfilepictureBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
