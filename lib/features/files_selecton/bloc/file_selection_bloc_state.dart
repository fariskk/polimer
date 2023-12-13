part of 'file_selection_bloc_bloc.dart';

@immutable
sealed class FileSelectionBlocState {}

final class FileSelectionBlocInitial extends FileSelectionBlocState {}

class UploadingState extends FileSelectionBlocState {}

class UploadSuccessState extends FileSelectionBlocState {}

class UploadFaildState extends FileSelectionBlocState {}
