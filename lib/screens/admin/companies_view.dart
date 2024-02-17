import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front/constants/app_colors.dart';
import 'package:front/cubit/companies/company_cubit.dart';
import 'package:front/models/company_model.dart';
import 'package:front/utils/helpers.dart';
import 'package:front/widgets/jh_button.dart';
import 'package:front/widgets/dialogs/jh_create_company_dialog.dart';
import 'package:front/widgets/dialogs/jh_edit_company_dialog.dart';
import 'package:front/widgets/jh_section_title.dart';
import 'package:front/widgets/jh_table.dart';
import 'package:front/widgets/jh_table_actions.dart';
import 'package:gap/gap.dart';

class AdminCompaniesView extends HookWidget {
  const AdminCompaniesView({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<CompanyCubit>().getCompanies();
      return null;
    }, const []);
    return Padding(
      padding: EdgeInsets.only(
        top: screenSize(context).height * 0.05,
        left: screenSize(context).width * 0.02,
        right: screenSize(context).width * 0.02,
      ),
      child: BlocBuilder<CompanyCubit, CompanyState>(
        builder: (context, state) {
          List<CompanyModel>? companies =
              context.watch<CompanyCubit>().companiesList;
          if (state is CompanyLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          if (companies != null) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const JHSectionTitle(
                        title: "Companies List",
                      ),
                      JHButton(
                          child: const Icon(Icons.create),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => const JHCreateCompanyDialog());
                          })
                    ],
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
                        "Name",
                      )),
                      DataColumn(
                          label: Text(
                        "Type",
                      )),
                      DataColumn(
                          label: Text(
                        "Payment Type",
                      )),
                      DataColumn(
                          label: Text(
                        "No of Jobs",
                      )),
                      DataColumn(
                          label: Text(
                        "Actions",
                      )),
                    ],
                    rows: [
                      for (int i = 0; i < companies.length; i++)
                        DataRow(
                          selected: true,
                          cells: [
                            DataCell(
                              Text('${i + 1}'),
                            ),
                            DataCell(
                              Text('${companies[i].name}'),
                            ),
                            DataCell(
                              SizedBox(
                                child: Text(
                                  '${companies[i].type}',
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(
                              Text('${companies[i].paymentType}'),
                            ),
                            DataCell(
                              SizedBox(
                                width: screenSize(context).width * 0.1,
                                child: Text('${companies[i].jobs!.length}'),
                              ),
                            ),
                            DataCell(
                              JHTableActions(
                                onShow: () {},
                                onDelete: state is CompanyDeleteLoading
                                    ? null
                                    : () {
                                        context
                                            .read<CompanyCubit>()
                                            .deleteCompany(companies[i].id!);
                                      },
                                onEdit: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => JHEditCompanyDialog(
                                      companyId: companies[i].id!,
                                      companyName: companies[i].name!,
                                      companyType: companies[i].type!,
                                      paymentType: companies[i].paymentType!,
                                    ),
                                  );
                                },
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
              "No Company Lists Yet",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        },
      ),
    );
  }
}
