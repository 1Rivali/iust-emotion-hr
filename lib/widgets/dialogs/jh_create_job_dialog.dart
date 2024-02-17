import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front/constants/app_colors.dart';
import 'package:front/cubit/companies/company_cubit.dart';
import 'package:front/cubit/jobs/jobs_cubit.dart';
import 'package:front/models/company_model.dart';
import 'package:front/utils/helpers.dart';
import 'package:front/widgets/jh_button.dart';
import 'package:gap/gap.dart';

class JHCreateJobDialog extends HookWidget {
  const JHCreateJobDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController titleController = useTextEditingController();
    final TextEditingController descriptionController =
        useTextEditingController();
    final TextEditingController companyIdController =
        useTextEditingController();
    int? companyId;

    useEffect(() {
      context.read<CompanyCubit>().getCompanies();
      return null;
    }, const []);
    return AlertDialog(
      title: Center(
        child: Text(
          "Create Job",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      content: Container(
        width: screenSize(context).width / 3,
        padding: EdgeInsets.symmetric(
            horizontal: screenSize(context).width * 0.015,
            vertical: screenSize(context).height * 0.03),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Company",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              BlocBuilder<CompanyCubit, CompanyState>(
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
                    return SizedBox(
                      width: double.infinity,
                      child: DropdownMenu(
                          hintText: "Select a Company",
                          controller: companyIdController,
                          onSelected: (value) {
                            companyId = value!;
                          },
                          inputDecorationTheme: InputDecorationTheme(
                            filled: true,
                            fillColor: primaryColor.withOpacity(0.05),
                          ),
                          dropdownMenuEntries: [
                            for (int i = 0; i < companies.length; i++)
                              DropdownMenuEntry(
                                  value: companies[i].id,
                                  label: companies[i].name!),
                          ]),
                    );
                  }
                  return const Text("No Data");
                },
              ),
              Text(
                "Title",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              TextFormField(
                controller: titleController,
                validator: (val) =>
                    val!.isNotEmpty ? null : "The Title field is required",
                decoration: InputDecoration(
                  filled: true,
                  fillColor: primaryColor.withOpacity(0.05),
                  hintText: "Title",
                ),
              ),
              const Gap(20),
              Text(
                "Description",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              Flexible(
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  controller: descriptionController,
                  validator: (val) => val!.isNotEmpty
                      ? null
                      : "The Description field is required",
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: primaryColor.withOpacity(0.05),
                    hintText: "Description",
                  ),
                ),
              ),
              const Gap(30),
              SizedBox(
                width: double.infinity,
                child: BlocConsumer<JobsCubit, JobsState>(
                  listener: (context, state) {
                    if (state is JobsCreateSuccess) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Job Created Successfuly")));
                    }
                  },
                  builder: (context, state) {
                    return JHButton(
                      onPressed: state is JobsCreateLoading
                          ? null
                          : () {
                              if (formKey.currentState!.validate() &&
                                  companyId != null) {
                                context.read<JobsCubit>().createJob(
                                      description: descriptionController.text,
                                      title: titleController.text,
                                      companyId: companyId!,
                                    );
                              }
                            },
                      child: state is JobsCreateLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text("Submit"),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
