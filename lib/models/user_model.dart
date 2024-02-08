// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String? token;
  final int? id;
  final String? email;
  final String? name;
  final bool? isAdmin;
  UserModel({
    this.token,
    this.id,
    this.email,
    this.name,
    this.isAdmin,
  });

  UserModel copyWith({
    String? token,
    int? id,
    String? email,
    String? name,
    bool? isAdmin,
  }) {
    return UserModel(
      token: token ?? this.token,
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'id': id,
      'email': email,
      'name': name,
      'is_superuser': isAdmin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      token: map['token'] != null ? map['token'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      isAdmin: map['is_superuser'] != null ? map['is_superuser'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(token: $token, id: $id, email: $email, name: $name, isAdmin: $isAdmin)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.token == token &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.isAdmin == isAdmin;
  }

  @override
  int get hashCode {
    return token.hashCode ^
        id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        isAdmin.hashCode;
  }
}
