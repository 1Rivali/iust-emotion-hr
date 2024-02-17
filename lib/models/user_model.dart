import 'dart:convert';

class UserModel {
  final String? token;
  final int? id;
  final String? email;
  final String? name;
  final String? cv;
  final bool? isAdmin;
  UserModel({
    this.token,
    this.id,
    this.email,
    this.name,
    this.cv,
    this.isAdmin,
  });

  UserModel copyWith({
    String? token,
    int? id,
    String? email,
    String? name,
    String? cv,
    bool? isAdmin,
  }) {
    return UserModel(
      token: token ?? this.token,
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      cv: cv ?? this.cv,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'id': id,
      'email': email,
      'name': name,
      'cv': cv,
      'is_superuser': isAdmin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      token: map['token'] != null ? map['token'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      cv: map['cv'] != null ? map['cv'] as String : null,
      isAdmin: map['is_superuser'] != null ? map['is_superuser'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(token: $token, id: $id, email: $email, name: $name, cv: $cv, isAdmin: $isAdmin)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.token == token &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.cv == cv &&
        other.isAdmin == isAdmin;
  }

  @override
  int get hashCode {
    return token.hashCode ^
        id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        cv.hashCode ^
        isAdmin.hashCode;
  }
}
