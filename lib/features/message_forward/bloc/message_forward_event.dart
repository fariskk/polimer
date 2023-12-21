part of 'message_forward_bloc.dart';

@immutable
sealed class MessageForwardEvent {}

class ReloadEvent extends MessageForwardEvent {}

class ForwardButtonClickedEvent extends MessageForwardEvent {
  List<Chatlist> users;
  Map message;
  BuildContext context;
  ForwardButtonClickedEvent(
      {required this.message, required this.users, required this.context});
}
