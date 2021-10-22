import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:soccer_app/models/message.dart';
import 'package:soccer_app/models/user_model.dart';

class ChatModel {
  String? id;
  UserModel? user;
  String? createdAt;
  List<MessageModel>? messages;
  ChatModel({
    this.id,
    this.user,
    this.createdAt,
    this.messages,
  });

  ChatModel copyWith({
    String? id,
    UserModel? user,
    String? createdAt,
    List<MessageModel>? messages,
  }) {
    return ChatModel(
      id: id ?? this.id,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user?.toMap(),
      'createdAt': createdAt,
      'messages': messages?.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'],
      user: UserModel.fromMap(map['user']),
      createdAt: map['createdAt'],
      messages: List<MessageModel>.from(
          map['messages']?.map((x) => MessageModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatModel(id: $id, user: $user, createdAt: $createdAt, messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatModel &&
        other.id == id &&
        other.user == user &&
        other.createdAt == createdAt &&
        listEquals(other.messages, messages);
  }

  @override
  int get hashCode {
    return id.hashCode ^ user.hashCode ^ createdAt.hashCode ^ messages.hashCode;
  }
}
