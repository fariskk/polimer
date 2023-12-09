class ChatList {
  ChatList({
    required this.username,
    required this.password,
    required this.chatlist,
  });
  late final String username;
  late final String password;
  late final List<Chatlist> chatlist;

  ChatList.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    chatlist =
        List.from(json['chatlist']).map((e) => Chatlist.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['password'] = password;
    _data['chatlist'] = chatlist.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Chatlist {
  Chatlist({
    required this.name,
    required this.db,
    required this.type,
    required this.image,
  });
  late final String name;
  late final String db;
  late final String type;
  late final String image;
  Chatlist.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    db = json['db'];
    type = json['type'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['db'] = db;
    _data['type'] = type;
    _data['image'] = image;
    return _data;
  }
}
