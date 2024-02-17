import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front/constants/app_colors.dart';
import 'package:front/cubit/auth/auth_cubit.dart';
import 'package:front/utils/helpers.dart';
import 'package:front/widgets/jh_button.dart';
import 'package:front/widgets/dialogs/jh_login_dialog.dart';
import 'package:gap/gap.dart';

class RegisterDialog extends HookWidget {
  const RegisterDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    MultipartFile? cv;
    return AlertDialog(
      title: Text(
        "Create a Free Job Harbor Account",
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      content: Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenSize(context).width * 0.015,
            vertical: screenSize(context).height * 0.03),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                validator: (val) => val!.isEmpty ? 'Name is Required' : null,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: primaryColor.withOpacity(0.05),
                  hintText: "Name",
                ),
              ),
              const Gap(20),
              Text(
                "Email",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              TextFormField(
                controller: emailController,
                validator: (val) => EmailValidator.validate(val!)
                    ? null
                    : "Please enter a valid email",
                decoration: InputDecoration(
                  filled: true,
                  fillColor: primaryColor.withOpacity(0.05),
                  hintText: "Email",
                ),
              ),
              const Gap(20),
              Text(
                "Password",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              TextFormField(
                controller: passwordController,
                validator: (val) =>
                    val!.isEmpty ? 'Password is Required' : null,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: primaryColor.withOpacity(0.05),
                  hintText: "Password",
                ),
              ),
              const Gap(25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();

                    if (result != null) {
                      cv = MultipartFile.fromBytes(result.files.single.bytes!,
                          filename: result.files.single.name);
                    }
                  },
                  icon: const Icon(Icons.file_copy),
                  label: const Text("Upload your CV"),
                ),
              ),
              const Gap(30),
              SizedBox(
                width: double.infinity,
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Account Created Successfuly!!")));
                      showDialog(
                        context: context,
                        builder: (context) => const LoginDialog(),
                      );
                    }
                    if (state is AuthFailure) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                  builder: (context, state) {
                    return JHButton(
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              if (formKey.currentState!.validate() &&
                                  cv != null) {
                                context.read<AuthCubit>().register(
                                      name: nameController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      cv: cv!,
                                    );
                              }
                            },
                      child: state is AuthLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text("Register"),
                    );
                  },
                ),
              ),
              const Gap(20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Already have an account?",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => const LoginDialog(),
                      );
                    },
                    child: Text(
                      "Login",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: primaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
