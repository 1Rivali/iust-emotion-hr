part of 'users_cubit.dart';

@immutable
sealed class UsersState {}

final class UsersInitial extends UsersState {}

final class UsersLoading extends UsersState {}

final class UsersSuccess extends UsersState {}

final class UsersFailure extends UsersState {}

final class UsersDeleteLoading extends UsersState {}

final class UsersDeleteSuccess extends UsersState {}

final class UsersDeleteFailure extends UsersState {}

final class UsersUpdateLoading extends UsersState {}

final class UsersUpdateSuccess extends UsersState {}

final class UsersUpdateFailure extends UsersState {}
