import 'dart:convert';

import 'package:front/models/company_model.dart';
import 'package:front/models/user_model.dart';

class CallModel {
  final int? id;
  final String? url;
  final String? startedAt;
  final UserModel? user;
  final CompanyModel? company;

  CallModel({
    this.id,
    this.url,
    this.startedAt,
    this.user,
    this.company,
  });

  CallModel copyWith({
    int? id,
    String? url,
    String? startedAt,
    UserModel? user,
    CompanyModel? company,
  }) {
    return CallModel(
      id: id ?? this.id,
      url: url ?? this.url,
      startedAt: startedAt ?? startedAt,
      user: user ?? this.user,
      company: company ?? this.company,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'started_at': startedAt,
      'user': user?.toMap(),
      'company': company?.toMap(),
    };
  }

  factory CallModel.fromMap(Map<String, dynamic> map) {
    return CallModel(
      id: map['id'] != null ? map['id'] as int : null,
      url: map['url'] != null ? map['url'] as String : null,
      startedAt: map['started_at'] != null ? map['started_at'] as String : null,
      user: map['user'] != null
          ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      company: map['company'] != null
          ? CompanyModel.fromMap(map['company'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CallModel.fromJson(String source) =>
      CallModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CallModel(id: $id, url: $url, started_at: $startedAt, user: $user, company: $company)';
  }

  @override
  bool operator ==(covariant CallModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.url == url &&
        other.startedAt == startedAt &&
        other.user == user &&
        other.company == company;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        url.hashCode ^
        startedAt.hashCode ^
        user.hashCode ^
        company.hashCode;
  }
}
