import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front/constants/app_colors.dart';
import 'package:front/cubit/auth/auth_cubit.dart';
import 'package:front/utils/helpers.dart';
import 'package:front/widgets/jh_button.dart';
import 'package:front/widgets/dialogs/jh_register_dialog.dart';
import 'package:gap/gap.dart';

class LoginDialog extends HookWidget {
  const LoginDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        "Login to Job Harbor",
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
              const Gap(30),
              SizedBox(
                width: double.infinity,
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      Navigator.pop(context);
                      if (state.isAdmin == true) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/admin", (route) => false);
                      }
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
                              if (formKey.currentState!.validate()) {
                                context.read<AuthCubit>().login(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                              }
                            },
                      child: state is AuthLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text("Login"),
                    );
                  },
                ),
              ),
              const Gap(20),
              Row(
                children: [
                  Text(
                    "Don't have an account?",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => const RegisterDialog(),
                      );
                    },
                    child: Text(
                      "Register",
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
