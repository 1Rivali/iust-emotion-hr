import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:front/models/user_model.dart';
import 'package:front/utils/cache_helper.dart';
import 'package:front/utils/dio_helper.dart';
import 'package:flutter/foundation.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  String? name;
  void login({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      Response<dynamic>? response =
          await DioHelper.postData(path: "auth/login/", data: {
        "email": email,
        "password": password,
      });
      UserModel user = UserModel.fromMap(response!.data);
      name = user.name;
      await CacheHelper.setString(key: "token", value: user.token!);
      await CacheHelper.setString(key: "name", value: user.name!);
      await CacheHelper.setString(
          key: "isAdmin", value: user.isAdmin!.toString());
      emit(AuthSuccess(isAdmin: user.isAdmin!));
    } on DioException catch (e) {
      emit(AuthFailure(error: e.response!.data["non_field_errors"][0]));
    }
  }

  void register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      emit(AuthLoading());
      Response<dynamic>? response = await DioHelper.postData(
          path: "auth/register/",
          data: {"name": name, "email": email, "password": password});
      UserModel user = UserModel.fromMap(response!.data);
      name = user.name!;
      await CacheHelper.setString(key: "name", value: user.name!);
      emit(AuthSuccess(isAdmin: false));
    } on DioException catch (e) {
      emit(AuthFailure(error: e.response!.data["email"][0]));
    }
  }

  Future<void> logout() async {
    await CacheHelper.removeData();
    emit(AuthLoggedOut());
  }

  bool isLoggedIn() {
    return CacheHelper.getData(key: "token") != null;
  }

  bool isAdmin() {
    String? isAdmin = CacheHelper.getData(key: "isAdmin");
    if (isAdmin != null) {
      return bool.parse(isAdmin, caseSensitive: false);
    }
    return false;
  }
}
