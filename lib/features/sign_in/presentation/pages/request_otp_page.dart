import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_primary_button.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_spacer.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_textfield.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/base_setting_row.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:nova_wheels/shared/utils/extensions/context_extension.dart';
import 'package:nova_wheels/shared/validators/input_validators.dart';
import 'package:nova_wheels/shared/values/app_assets_path.dart';
import 'package:nova_wheels/shared/values/app_values.dart';

class RequestOtpPage extends StatefulWidget {
  const RequestOtpPage({super.key});

  @override
  State<RequestOtpPage> createState() => _RequestOtpPageState();
}

class _RequestOtpPageState extends State<RequestOtpPage> {
  late final TextEditingController _emailController;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
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
      if (state.status == SignInStatus.otpSent) {
        context.goNamed(Routes.verifyOtpPage);
      }
    }, builder: (context, state) {
      return Scaffold(
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
                      _buildEmailTextField(state),
                      const AppSpacer(),
                      _buildRequestOTPButton(state),
                      const AppSpacer(height: AppValues.height_16),
                      _buildSignInWith(context),
                      const AppSpacer(height: AppValues.height_16),
                      _buildSocialLogIn(context),
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

  Widget _buildSocialLogIn(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: SvgPicture.asset(AppAssets.googleSVG),
            onPressed: () {},
          ),
          const AppSpacer(width: AppValues.padding),
          IconButton(
            icon: SvgPicture.asset(AppAssets.facebookSVG),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildRequestOTPButton(SignInState state) {
    return state.status == SignInStatus.loading
        ? const CircularProgressIndicator()
        : AppPrimaryButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<SignInBloc>().add(
                      RequestOtpSubmitted(
                        email: _emailController.text.trim(),
                      ),
                    );
              }
            },
            title: "Request OTP");
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

  Widget _buildSignInWith(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(
            flex: 1,
            child: Divider(),
          ),
          Flexible(
            flex: 3,
            child: FittedBox(
                child: Text(context.localization?.orSignInWith ?? "")),
          ),
          const Flexible(
            flex: 1,
            child: Divider(),
          ),
        ],
      ),
    );
  }

  //
  Widget _buildEmailTextField(SignInState state) {
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
          isEnabled: state.status != SignInStatus.loading,
          prefix: const Icon(Icons.email_outlined),
          controller: _emailController,
          labelText: context.localization?.fieldLabelTextEmail ?? "",
          validator: InputValidators.email,
          onChanged: (value) {
            context
                .read<SignInBloc>()
                .add(EmailChangeEvent(email: value.toString()));
          },
        ),
      ),
    );
  }
}
