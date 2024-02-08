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

  Future<void> deleteCalls(int id) async {
    try {
      emit(CallsDeleteLoading());
      await DioHelper.deleteDataAuth(path: "call/$id/");
      await getCalls();
      emit(CallsDeleteSuccess());
    } on DioException catch (e) {
      emit(CallsDeleteFailure());
    }
  }
}
