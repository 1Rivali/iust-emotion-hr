part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentSuccess extends PaymentState {}

final class PaymentFailure extends PaymentState {}

final class PaymentsDeleteLoading extends PaymentState {}

final class PaymentsDeleteSuccess extends PaymentState {}

final class PaymentsDeleteFailure extends PaymentState {}
