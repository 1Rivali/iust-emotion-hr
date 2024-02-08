import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/models/payment_model.dart';
import 'package:flutter/foundation.dart';
import 'package:front/utils/dio_helper.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  List<PaymentModel>? paymentsList;
  Future<void> getPayments() async {
    try {
      emit(PaymentLoading());
      Response<dynamic>? response =
          await DioHelper.getDataAuth(path: "payment/");

      paymentsList = (response!.data as List<dynamic>)
          .map((e) => PaymentModel.fromMap(e as Map<String, dynamic>))
          .toList();
      emit(PaymentSuccess());
    } on DioException catch (e) {
      emit(PaymentFailure());
    }
  }

  Future<void> deletePayment(int id) async {
    try {
      emit(PaymentsDeleteLoading());
      await DioHelper.deleteDataAuth(path: "payment/payment/$id/");
      await getPayments();
      emit(PaymentsDeleteFailure());
    } on DioException catch (e) {
      emit(PaymentsDeleteFailure());
    }
  }
}
