import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:front/models/job_model.dart';
import 'package:front/utils/dio_helper.dart';
import 'package:flutter/foundation.dart';

part 'jobs_state.dart';

class JobsCubit extends Cubit<JobsState> {
  JobsCubit() : super(JobsInitial());

  List<JobModel>? jobs;
  Future<void> getJobs() async {
    try {
      emit(JobsLoading());
      Response<dynamic>? response = await DioHelper.getData(path: "job/list/");
      List<dynamic> data = response!.data;
      jobs =
          data.map((e) => JobModel.fromMap(e as Map<String, dynamic>)).toList();
      emit(JobsSuccess());
    } catch (e) {
      emit(JobsFailure());
    }
  }

  Future<void> deleteJob(int id) async {
    try {
      emit(JobsDeleteLoading());
      await DioHelper.deleteDataAuth(path: "job/$id/");
      await getJobs();
      emit(JobsDeleteSuccess());
    } on DioException catch (e) {
      emit(JobsDeleteFailure());
    }
  }

  Future<void> updateJob({required String email, required String name}) async {
    try {
      emit(JobsUpdateLoading());
      // await
    } catch (e) {}
  }
}
