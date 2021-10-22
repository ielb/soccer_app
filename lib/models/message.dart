import 'dart:convert';

class MessageModel {
  String? body;
  int? read;
  String? uid;
  String? chatId;
  String? createdAt;
  MessageModel({
    this.body,
    this.read,
    this.uid,
    this.chatId,
    this.createdAt,
  });

  MessageModel copyWith({
    String? body,
    int? read,
    String? uid,
    String? chatId,
    String? createdAt,
  }) {
    return MessageModel(
      body: body ?? this.body,
      read: read ?? this.read,
      uid: uid ?? this.uid,
      chatId: chatId ?? this.chatId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'body': body,
      'read': read,
      'uid': uid,
      'chatId': chatId,
      'createdAt': createdAt,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      body: map['body'],
      read: map['read'],
      uid: map['uid'],
      chatId: map['chatId'],
      createdAt: map['createdAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessageModel(body: $body, read: $read, uid: $uid, chatId: $chatId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel &&
        other.body == body &&
        other.read == read &&
        other.uid == uid &&
        other.chatId == chatId &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return body.hashCode ^
        read.hashCode ^
        uid.hashCode ^
        chatId.hashCode ^
        createdAt.hashCode;
  }
}
