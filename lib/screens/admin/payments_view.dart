import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front/constants/app_colors.dart';
import 'package:front/cubit/payments/payment_cubit.dart';
import 'package:front/models/payment_model.dart';
import 'package:front/utils/helpers.dart';
import 'package:front/widgets/jh_section_title.dart';
import 'package:front/widgets/jh_table.dart';
import 'package:front/widgets/jh_table_actions.dart';
import 'package:gap/gap.dart';

class AdminPaymentsView extends HookWidget {
  const AdminPaymentsView({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<PaymentCubit>().getPayments();
      return null;
    }, const []);
    return Padding(
      padding: EdgeInsets.only(
        top: screenSize(context).height * 0.05,
        left: screenSize(context).width * 0.02,
        right: screenSize(context).width * 0.02,
      ),
      child: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          List<PaymentModel>? payments =
              context.watch<PaymentCubit>().paymentsList;
          if (state is PaymentLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          if (payments != null) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const JHSectionTitle(
                    title: "Payments List",
                  ),
                  const Gap(40),
                  JHTable(
                    columns: const [
                      DataColumn(
                          label: Text(
                        "#",
                      )),
                      DataColumn(
                          label: Text(
                        "Payment Amount",
                      )),
                      DataColumn(
                          label: Text(
                        "Payment Type",
                      )),
                      DataColumn(
                          label: Text(
                        "Company Name",
                      )),
                      DataColumn(
                          label: Text(
                        "Actions",
                      )),
                    ],
                    rows: [
                      for (int i = 0; i < payments.length; i++)
                        DataRow(
                          selected: true,
                          cells: [
                            DataCell(
                              Text('${i + 1}'),
                            ),
                            DataCell(
                              Text('${payments[i].amount}'),
                            ),
                            DataCell(
                              SizedBox(
                                child: Text(
                                  '${payments[i].company!.paymentType}',
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(
                              Text('${payments[i].company!.name}'),
                            ),
                            DataCell(
                              JHTableActions(
                                onDelete: state is PaymentsDeleteLoading
                                    ? null
                                    : () {
                                        context
                                            .read<PaymentCubit>()
                                            .deletePayment(payments[i].id!);
                                      },
                                onEdit: () {},
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ],
              ),
            );
          }
          return Center(
            child: Text(
              "No Payments Lists Yet",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        },
      ),
    );
  }
}
