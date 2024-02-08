part of 'calls_cubit.dart';

@immutable
sealed class CallsState {}

final class CallsInitial extends CallsState {}

final class CallsLoading extends CallsState {}

final class CallsSuccess extends CallsState {}

final class CallsFailure extends CallsState {}

final class CallsDeleteLoading extends CallsState {}

final class CallsDeleteSuccess extends CallsState {}

final class CallsDeleteFailure extends CallsState {}
