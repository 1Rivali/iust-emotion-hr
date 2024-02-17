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

  Future<void> updateJob(
      {required int id,
      required String description,
      required String title}) async {
    try {
      emit(JobsUpdateLoading());
      await DioHelper.patchDataAuth(path: "job/$id/", data: {
        "description": description,
        "title": title,
      });
      await getJobs();
      emit(JobsUpdateSuccess());
    } catch (e) {
      emit(JobsUpdateFailure());
    }
  }

  Future<void> createJob(
      {required String title,
      required String description,
      required int companyId}) async {
    try {
      emit(JobsCreateLoading());
      await DioHelper.postDataAuth(path: "job/create/", data: {
        "title": title,
        "description": description,
        "company": companyId,
      });
      await getJobs();
      emit(JobsCreateSuccess());
    } on DioException catch (e) {
      emit(JobsCreateFailure());
    }
  }
}
