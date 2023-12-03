class Userdata {
  Userdata({
    required this.username,
    required this.password,
    required this.messages,
  });
  late final String username;
  late final String password;
  late final List<Messages> messages;

  Userdata.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    messages =
        List.from(json['messages']).map((e) => Messages.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['password'] = password;
    _data['messages'] = messages.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Messages {
  Messages({
    required this.sender,
    required this.senderimage,
    required this.time,
    required this.content,
    required this.type,
  });
  late final String sender;
  late final String senderimage;
  late final String time;
  late final String content;
  late final String type;

  Messages.fromJson(Map<String, dynamic> json) {
    sender = json['sender'];
    senderimage = json['senderimage'];
    time = json['time'];
    content = json['content'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sender'] = sender;
    _data['senderimage'] = senderimage;
    _data['time'] = time;
    _data['content'] = content;
    _data['type'] = type;
    return _data;
  }
}
