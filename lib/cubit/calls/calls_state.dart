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

final class CallsUpdateLoading extends CallsState {}

final class CallsUpdateSuccess extends CallsState {}

final class CallsUpdateFailure extends CallsState {}

final class CallCreateLoading extends CallsState {}

final class CallCreateSuccess extends CallsState {}

final class CallCreateFailure extends CallsState {}

final class CallRoomLoading extends CallsState {}

final class CallRoomSuccess extends CallsState {}

final class CallRoomFailure extends CallsState {}
