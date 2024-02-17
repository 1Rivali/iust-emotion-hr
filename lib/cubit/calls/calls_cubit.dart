import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:flutter/foundation.dart";
import 'package:front/models/call_model.dart';
import 'package:front/utils/dio_helper.dart';

part 'calls_state.dart';

class CallsCubit extends Cubit<CallsState> {
  CallsCubit() : super(CallsInitial());
  List<CallModel>? callsList;
  Future<void> getCalls() async {
    try {
      emit(CallsLoading());
      Response<dynamic>? response = await DioHelper.getDataAuth(path: "call/");

      List<CallModel>? calls = (response!.data as List<dynamic>)
          .map((e) => CallModel.fromMap(e as Map<String, dynamic>))
          .toList();
      callsList = calls;
      emit(CallsSuccess());
    } on DioException catch (e) {
      emit(CallsFailure());
    }
  }

  String? createdCallUrl;
  Future<void> createCall({required int companyId, required int userId}) async {
    const characters = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random random = Random();
    createdCallUrl = String.fromCharCodes(Iterable.generate(
        15, (_) => characters.codeUnitAt(random.nextInt(10))));

    try {
      emit(CallCreateLoading());
      await DioHelper.postDataAuth(path: "call/create/", data: {
        "url": createdCallUrl,
        "user": userId,
        "company": companyId,
      });
      emit(CallCreateSuccess());
    } on DioException catch (e) {
      emit(CallCreateFailure());
    }
  }

  Future<void> deleteCall(int id) async {
    try {
      emit(CallsDeleteLoading());
      await DioHelper.deleteDataAuth(path: "call/$id/");
      await getCalls();
      emit(CallsDeleteSuccess());
    } on DioException catch (e) {
      emit(CallsDeleteFailure());
    }
  }

  Future<void> updateCall({required int id, required String url}) async {
    try {
      emit(CallsUpdateLoading());
      await DioHelper.patchDataAuth(path: "call/$id/", data: {"url": url});
      await getCalls();
      emit(CallsUpdateSuccess());
    } on DioException catch (e) {
      emit(CallsUpdateFailure());
    }
  }
}
