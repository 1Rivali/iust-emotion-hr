// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:front/models/job_model.dart';

class CompanyModel {
  final int? id;
  final String? name;
  final String? type;
  final String? paymentType;
  final List<JobModel>? jobs;

  CompanyModel({
    this.id,
    this.name,
    this.type,
    this.paymentType,
    this.jobs,
  });

  CompanyModel copyWith({
    int? id,
    String? name,
    String? type,
    String? paymentType,
    List<JobModel>? jobs,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      paymentType: paymentType ?? this.paymentType,
      jobs: jobs ?? this.jobs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'payment_type': paymentType,
      'company_jobs': jobs?.map((x) => x.toMap()).toList(),
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      paymentType:
          map['payment_type'] != null ? map['payment_type'] as String : null,
      jobs: map['company_jobs'] != null
          ? (map['company_jobs'] as List<dynamic>)
              .map((e) => JobModel.fromMap(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) =>
      CompanyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CompanyModel(id: $id, name: $name, type: $type, paymentType: $paymentType, jobs: $jobs)';
  }

  @override
  bool operator ==(covariant CompanyModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.type == type &&
        other.paymentType == paymentType &&
        listEquals(other.jobs, jobs);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        type.hashCode ^
        paymentType.hashCode ^
        jobs.hashCode;
  }
}
