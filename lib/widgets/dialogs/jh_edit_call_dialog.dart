import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front/constants/app_colors.dart';
import 'package:front/cubit/calls/calls_cubit.dart';
import 'package:front/utils/helpers.dart';
import 'package:front/widgets/jh_button.dart';
import 'package:gap/gap.dart';

class JHEditCallDialog extends HookWidget {
  const JHEditCallDialog({
    super.key,
    required this.callId,
    required this.callUrl,
  });
  final int callId;
  final String callUrl;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController urlController = useTextEditingController();

    useEffect(() {
      urlController.text = callUrl;
      return null;
    }, const []);
    return AlertDialog(
      title: Center(
        child: Text(
          "Edit Call",
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
                "URL",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              TextFormField(
                controller: urlController,
                validator: (val) =>
                    val!.isNotEmpty ? null : "The URL field is required",
                decoration: InputDecoration(
                  filled: true,
                  fillColor: primaryColor.withOpacity(0.05),
                  hintText: "URL",
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: BlocConsumer<CallsCubit, CallsState>(
                  listener: (context, state) {
                    if (state is CallsUpdateSuccess) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Call Updated Successfuly")));
                    }
                  },
                  builder: (context, state) {
                    return JHButton(
                      onPressed: state is CallsUpdateLoading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                context.read<CallsCubit>().updateCall(
                                      id: callId,
                                      url: urlController.text,
                                    );
                              }
                            },
                      child: state is CallsUpdateLoading
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
