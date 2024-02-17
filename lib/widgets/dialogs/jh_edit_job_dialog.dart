import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front/constants/app_colors.dart';
import 'package:front/cubit/jobs/jobs_cubit.dart';
import 'package:front/utils/helpers.dart';
import 'package:front/widgets/jh_button.dart';
import 'package:gap/gap.dart';

class JHEditJobDialog extends HookWidget {
  const JHEditJobDialog({
    super.key,
    required this.jobId,
    required this.jobTitle,
    required this.jobDescription,
  });
  final int jobId;
  final String jobTitle;
  final String jobDescription;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController titleController = useTextEditingController();
    final TextEditingController descriptionController =
        useTextEditingController();
    useEffect(() {
      descriptionController.text = jobDescription;
      titleController.text = jobTitle;
      return null;
    }, const []);
    return AlertDialog(
      title: Center(
        child: Text(
          "Edit Job",
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
                    if (state is JobsUpdateSuccess) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Job Updated Successfuly")));
                    }
                  },
                  builder: (context, state) {
                    return JHButton(
                      onPressed: state is JobsUpdateLoading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                context.read<JobsCubit>().updateJob(
                                      id: jobId,
                                      description: descriptionController.text,
                                      title: titleController.text,
                                    );
                              }
                            },
                      child: state is JobsUpdateLoading
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



// showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       final formKey = GlobalKey<FormState>();
//                                       return AlertDialog(
//                                         title: Center(
//                                           child: Text(
//                                             "Edit user",
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .titleLarge!
//                                                 .copyWith(
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                           ),
//                                         ),
//                                         content: Container(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal:
//                                                   screenSize(context).width *
//                                                       0.015,
//                                               vertical:
//                                                   screenSize(context).height *
//                                                       0.03),
//                                           child: Form(
//                                             key: formKey,
//                                             autovalidateMode: AutovalidateMode
//                                                 .onUserInteraction,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: [
//                                                 Text(
//                                                   "Email",
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .titleMedium!
//                                                       .copyWith(
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                 ),
//                                                 const Gap(10),
//                                                 TextFormField(
//                                                   controller: emailController,
//                                                   validator: (val) =>
//                                                       EmailValidator.validate(
//                                                               val!)
//                                                           ? null
//                                                           : "Please enter a valid email",
//                                                   decoration: InputDecoration(
//                                                     filled: true,
//                                                     fillColor: primaryColor
//                                                         .withOpacity(0.05),
//                                                     hintText: "Email",
//                                                   ),
//                                                 ),
//                                                 const Gap(20),
//                                                 Text(
//                                                   "Name",
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .titleMedium!
//                                                       .copyWith(
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                 ),
//                                                 const Gap(10),
//                                                 TextFormField(
//                                                   controller: nameController,
//                                                   validator: (val) =>
//                                                       EmailValidator.validate(
//                                                               val!)
//                                                           ? null
//                                                           : "The name field is required",
//                                                   decoration: InputDecoration(
//                                                     filled: true,
//                                                     fillColor: primaryColor
//                                                         .withOpacity(0.05),
//                                                     hintText: "Name",
//                                                   ),
//                                                 ),
//                                                 const Gap(30),
//                                                 SizedBox(
//                                                   width: double.infinity,
//                                                   child: BlocConsumer<
//                                                       UsersCubit, UsersState>(
//                                                     listener: (context, state) {
//                                                       // TODO: implement listener
//                                                     },
//                                                     builder: (context, state) {
//                                                       return JHButton(
//                                                         onPressed:
//                                                             state is JobsLoading
//                                                                 ? null
//                                                                 : () {
//                                                                     if (formKey
//                                                                         .currentState!
//                                                                         .validate()) {
//                                                                       context
//                                                                           .read<
//                                                                               UsersCubit>()
//                                                                           .updateUser(
//                                                                             email:
//                                                                                 emailController.text.trim(),
//                                                                             name:
//                                                                                 nameController.text.trim(),
//                                                                           );
//                                                                     }
//                                                                   },
//                                                         child: state
//                                                                 is JobsLoading
//                                                             ? const CircularProgressIndicator(
//                                                                 color: Colors
//                                                                     .white,
//                                                               )
//                                                             : const Text(
//                                                                 "Submit"),
//                                                       );
//                                                     },
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   );