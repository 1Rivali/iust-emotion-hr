part of 'jobs_cubit.dart';

@immutable
sealed class JobsState {}

final class JobsInitial extends JobsState {}

final class JobsLoading extends JobsState {}

final class JobsSuccess extends JobsState {}

final class JobsFailure extends JobsState {}

final class JobsDeleteLoading extends JobsState {}

final class JobsDeleteSuccess extends JobsState {}

final class JobsDeleteFailure extends JobsState {}

final class JobsUpdateLoading extends JobsState {}

final class JobsUpdateSuccess extends JobsState {}

final class JobsUpdateFailure extends JobsState {}
