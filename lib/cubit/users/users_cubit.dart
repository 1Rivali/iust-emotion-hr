import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:front/models/user_model.dart';
import 'package:front/utils/dio_helper.dart';
import 'package:flutter/foundation.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());
  List<UserModel>? usersList;
  Future<void> getUsers() async {
    try {
      emit(UsersLoading());
      Response<dynamic>? response =
          await DioHelper.getDataAuth(path: "/auth/user/list/");
      List<UserModel> users = (response!.data as List<dynamic>)
          .map((e) => UserModel.fromMap(e))
          .toList();
      usersList = users;
      emit(UsersSuccess());
    } on DioException catch (e) {
      emit(UsersFailure());
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      emit(UsersDeleteLoading());
      await DioHelper.deleteDataAuth(path: "auth/user/$id/");
      await getUsers();
      emit(UsersDeleteSuccess());
    } on DioException catch (e) {
      emit(UsersDeleteFailure());
    }
  }
}
