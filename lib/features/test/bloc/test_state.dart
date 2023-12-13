part of 'test_bloc.dart';

@immutable
sealed class TestState {}

final class TestInitial extends TestState {}

class TestLoadingState extends TestState {}

class TestSuccesstate extends TestState {}
