import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:polimer/features/profilepicture_selection/bloc/profilepicture_bloc_bloc.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestInitial()) {
    on<TestButtonClickedEvent>((event, emit) async {
      emit(TestLoadingState());
      await Future.delayed(Duration(seconds: 10), () {
        emit(TestSuccesstate());
      });
    });
  }
}
