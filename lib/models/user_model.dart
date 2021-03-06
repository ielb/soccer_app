import 'dart:convert';

class UserModel {
  String uid = '';
  String name = '';
  String email = '';
  String? avatar;
  int? age;
  String? team;
  String? coach;
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.avatar,
    this.age,
    this.team,
    this.coach,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? avatar,
    int? age,
    String? team,
    String? coach,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      age: age ?? this.age,
      team: team ?? this.team,
      coach: coach ?? this.coach,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'avatar': avatar,
      'age': age,
      'team': team,
      'coach': coach,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      avatar: map['avatar'],
      age: map['age'],
      team: map['team'],
      coach: map['coach'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, avatar: $avatar, age: $age, team: $team, coach: $coach)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.avatar == avatar &&
        other.age == age &&
        other.team == team &&
        other.coach == coach;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        avatar.hashCode ^
        age.hashCode ^
        team.hashCode ^
        coach.hashCode;
  }
}
