import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_primary_button.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_spacer.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/base_setting_row.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:nova_wheels/shared/utils/extensions/context_extension.dart';
import 'package:nova_wheels/shared/values/app_assets_path.dart';
import 'package:nova_wheels/shared/values/app_values.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  late final TextEditingController _otpController;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(listener: (context, state) {
      if (state.status == SignInStatus.failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
      if (state.status == SignInStatus.otpVerified) {
        context.goNamed(Routes.resetPasswordPage);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("OTP Verification page"),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const ChangeSetting(),
                      _buildAppHeader(),
                      const AppSpacer(),
                      _buildOtpTextField(state),
                      const AppSpacer(),
                      _buildVerifyOTPButton(state),
                      const AppSpacer(height: AppValues.height_16),
                      _buildDontHaveAccount(),
                      const Gap(100),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Image _buildAppHeader() {
    return Image.asset(
      AppAssets.appLogo,
      height: 120.0,
      width: 120.0,
    );
  }

  Widget _buildVerifyOTPButton(SignInState state) {
    return state.status == SignInStatus.loading
        ? const CircularProgressIndicator()
        : AppPrimaryButton(
            onPressed: () {
              context.read<SignInBloc>().add(
                    VerifyOtpSubmitted(
                      otp: _otpController.text.trim(),
                    ),
                  );
            },
            title: "Verify OTP");
  }

  Widget _buildDontHaveAccount() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(context.localization?.dontHaveAccount ?? ""),
        const AppSpacer(width: AppValues.halfPadding),
        TextButton(
            onPressed: () {
              context.goNamed(Routes.signUp);
            },
            child: Text(context.localization?.signUp ?? ""))
      ],
    );
  }

  Widget _buildOtpTextField(SignInState state) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(
          left: AppValues.margin_2,
        ),
        child: Text(
          context.localization?.fieldTitleEmail ?? "",
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: AppValues.smallMargin),
        child: AppTextField(
          enabled: state.status != SignInStatus.loading,
          prefix: const Icon(Icons.email_outlined),
          textController: _otpController,
          labelText: "",
          onChanged: (value) {},
        ),
      ),
    );
  }
}
