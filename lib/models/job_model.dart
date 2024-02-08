// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:front/models/company_model.dart';

class JobModel {
  final int? id;
  final String? title;
  final String? description;
  final int? countApplicants;
  final CompanyModel? company;

  JobModel({
    this.id,
    this.title,
    this.description,
    this.countApplicants,
    this.company,
  });

  JobModel copyWith({
    int? id,
    String? title,
    String? description,
    int? countApplicants,
    CompanyModel? company,
  }) {
    return JobModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      countApplicants: countApplicants ?? this.countApplicants,
      company: company ?? this.company,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'count_applicants': countApplicants,
      'company': company?.toMap(),
    };
  }

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      countApplicants: map['count_applicants'] != null
          ? map['count_applicants'] as int
          : null,
      company: map['company'] != null
          ? CompanyModel.fromMap(map['company'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory JobModel.fromJson(String source) =>
      JobModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'JobModel(id: $id, title: $title, description: $description, countApplicants: $countApplicants, company: $company)';
  }

  @override
  bool operator ==(covariant JobModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.countApplicants == countApplicants &&
        other.company == company;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        countApplicants.hashCode ^
        company.hashCode;
  }
}
