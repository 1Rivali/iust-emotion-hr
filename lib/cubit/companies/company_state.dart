part of 'company_cubit.dart';

@immutable
sealed class CompanyState {}

final class CompanyInitial extends CompanyState {}

final class CompanyLoading extends CompanyState {}

final class CompanySuccess extends CompanyState {}

final class CompanyFailure extends CompanyState {}

final class CompanyDeleteLoading extends CompanyState {}

final class CompanyDeleteSuccess extends CompanyState {}

final class CompanyDeleteFailure extends CompanyState {}
