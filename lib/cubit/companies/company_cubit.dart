import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:flutter/foundation.dart";
import 'package:front/models/company_model.dart';
import 'package:front/utils/dio_helper.dart';

part 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(CompanyInitial());

  List<CompanyModel>? companiesList;
  Future<void> getCompanies() async {
    try {
      emit(CompanyLoading());
      Response<dynamic>? response = await DioHelper.getData(path: "company/");

      List<CompanyModel>? companies = (response!.data as List<dynamic>)
          .map((e) => CompanyModel.fromMap(e as Map<String, dynamic>))
          .toList();
      companiesList = companies;
      emit(CompanySuccess());
    } on DioException catch (e) {
      emit(CompanyFailure());
    }
  }

  Future<void> createCompany(
      {required String name,
      required String type,
      required String paymentType}) async {
    try {
      emit(CompanyCreateLoading());
      await DioHelper.postDataAuth(path: "company/create/", data: {
        "name": name,
        "type": type,
        "payment_type": paymentType,
      });
      await getCompanies();
      emit(CompanyCreateSuccess());
    } on DioException catch (e) {
      emit(CompanyCreateFailure());
    }
  }

  Future<void> deleteCompany(int id) async {
    try {
      emit(CompanyDeleteLoading());
      await DioHelper.deleteDataAuth(path: "company/$id/");
      await getCompanies();
      emit(CompanyDeleteSuccess());
    } on DioException catch (e) {
      emit(CompanyDeleteFailure());
    }
  }

  Future<void> updateCompany(
      {required int id,
      required String name,
      required String type,
      required String paymentType}) async {
    try {
      emit(CompanyUpdateLoading());
      await DioHelper.patchDataAuth(path: "company/$id/", data: {
        "name": name,
        "type": type,
        "payment_type": paymentType,
      });
      await getCompanies();
      emit(CompanyUpdateSuccess());
    } catch (e) {
      emit(CompanyUpdateFailure());
    }
  }
}
