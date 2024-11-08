import 'package:equatable/equatable.dart';

enum Sender { user, gemini }

extension SenderExtension on Sender {
  Map<String, dynamic> toMap() {
    return {'index': index, 'name': name};
  }
}

class ChatContent extends Equatable {
  final Sender sender;
  final String message;

  const ChatContent.user(this.message) : sender = Sender.user;

  const ChatContent.gemini(this.message) : sender = Sender.gemini;

  @override
  List<Object?> get props => [sender, message];

  Map<String, dynamic> toMap() => {
        'message': message,
        'sender': sender.toMap(),
      };
}
