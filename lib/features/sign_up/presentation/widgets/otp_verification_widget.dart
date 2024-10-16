import 'package:app_ui/app_ui.dart' show AppScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_primary_button.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_textfield.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:nova_wheels/shared/utils/utils.dart';

class OTPVerificationView extends StatefulWidget {
  const OTPVerificationView({super.key});

  @override
  State<OTPVerificationView> createState() => _OTPVerificationViewState();
}

class _OTPVerificationViewState extends State<OTPVerificationView> {
  final TextEditingController _otpEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AppLocalizations? _appLocalizations;

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context);

    return BlocConsumer<SignUpBloc, SignUpState>(listener: (context, state) {
      if (state.status == SignUpStatus.success) {
        showSnackBarMessage(
            context, "Successfully Signed Up", SnackBarMessageType.success);
        context.read<SignUpBloc>().add(SignUpStatusChange());
        context.goNamed(Routes.home);
      } else if (state.status == SignUpStatus.failure) {
        showSnackBarMessage(
          context,
          state.errorMessage,
          SnackBarMessageType.failure,
        );
      }
    }, builder: (context, state) {
      return AppScaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(_appLocalizations?.fieldLabelTextOTP ?? ""),
                    ),
                    subtitle: AppTextField(
                      keyboardType: TextInputType.number,
                      controller: _otpEditingController,
                      // validator: InputValidators.otp,
                      labelText: _appLocalizations?.fieldTitleOTP ?? "",
                      onChanged: (value) {
                        context
                            .read<SignUpBloc>()
                            .add(OTPChangeEvent(otp: value.toString()));
                      },
                    ),
                  ),
                  state.status == SignUpStatus.loading
                      ? const CircularProgressIndicator()
                      : AppPrimaryButton(
                          onPressed: () {
                            context.read<SignUpBloc>().add(VerifyOTPEvent());
                          },
                          title: _appLocalizations?.verifyOTP ?? "",
                        ),
                  const SizedBox(height: 8),
                  Text(
                      'If you didn\'t receive the OTP or Has expired, tap to resend'),
                  TextButton(
                    onPressed: () {
                      context.read<SignUpBloc>().add(ResendOTPSubmitted());
                    },
                    child: Text(
                      "Resend OTP",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
