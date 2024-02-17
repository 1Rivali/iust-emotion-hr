import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front/constants/app_colors.dart';
import 'package:front/cubit/companies/company_cubit.dart';
import 'package:front/utils/helpers.dart';
import 'package:front/widgets/jh_button.dart';
import 'package:gap/gap.dart';

class JHCreateCompanyDialog extends HookWidget {
  const JHCreateCompanyDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController nameController = useTextEditingController();
    final TextEditingController typeController = useTextEditingController();
    final TextEditingController paymentController = useTextEditingController();
    return AlertDialog(
      title: Center(
        child: Text(
          "Create Company",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      content: Container(
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
                "Name",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              TextFormField(
                controller: nameController,
                validator: (val) =>
                    val!.isNotEmpty ? null : "The Name field is required",
                decoration: InputDecoration(
                  filled: true,
                  fillColor: primaryColor.withOpacity(0.05),
                  hintText: "Name",
                ),
              ),
              const Gap(20),
              Text(
                "Type",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              TextFormField(
                controller: typeController,
                validator: (val) =>
                    val!.isNotEmpty ? null : "The Type field is required",
                decoration: InputDecoration(
                  filled: true,
                  fillColor: primaryColor.withOpacity(0.05),
                  hintText: "Type",
                ),
              ),
              const Gap(30),
              const Gap(20),
              Text(
                "Payment Type",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              TextFormField(
                controller: paymentController,
                validator: (val) =>
                    val!.isNotEmpty ? null : "The Type field is required",
                decoration: InputDecoration(
                  filled: true,
                  fillColor: primaryColor.withOpacity(0.05),
                  hintText: "Payment Type",
                ),
              ),
              const Gap(30),
              SizedBox(
                width: double.infinity,
                child: BlocConsumer<CompanyCubit, CompanyState>(
                  listener: (context, state) {
                    if (state is CompanyCreateSuccess) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Company Created Successfuly")));
                    }
                  },
                  builder: (context, state) {
                    return JHButton(
                      onPressed: state is CompanyCreateLoading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                context.read<CompanyCubit>().createCompany(
                                      type: typeController.text,
                                      name: nameController.text,
                                      paymentType: paymentController.text,
                                    );
                              }
                            },
                      child: state is CompanyCreateLoading
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
