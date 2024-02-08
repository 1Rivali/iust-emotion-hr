import 'dart:convert';

import 'package:front/models/company_model.dart';

class PaymentModel {
  final int? id;
  final int? amount;
  final CompanyModel? company;
  PaymentModel({
    this.id,
    this.amount,
    this.company,
  });

  PaymentModel copyWith({
    int? id,
    int? amount,
    CompanyModel? company,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      company: company ?? this.company,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'company': company?.toMap(),
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['id'] != null ? map['id'] as int : null,
      amount: map['amount'] != null ? map['amount'] as int : null,
      company: map['company'] != null
          ? CompanyModel.fromMap(map['company'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentModel.fromJson(String source) =>
      PaymentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PaymentModel(id: $id, amount: $amount, company: $company)';

  @override
  bool operator ==(covariant PaymentModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.amount == amount && other.company == company;
  }

  @override
  int get hashCode => id.hashCode ^ amount.hashCode ^ company.hashCode;
}
