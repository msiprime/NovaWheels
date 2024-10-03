import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_primary_button.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_spacer.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:nova_wheels/shared/utils/extensions/context_extension.dart'
    as ext show ContextExt;
import 'package:nova_wheels/shared/values/app_assets_path.dart';
import 'package:nova_wheels/shared/values/app_values.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late final TextEditingController _passwordController;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
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
      if (state.status == SignInStatus.success) {
        context.goNamed(Routes.signIn);
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // const ChangeSetting(),
                      _buildAppHeader(),
                      const AppSpacer(),
                      _buildPasswordTextField(state),
                      const AppSpacer(),
                      _buildResetPasswordButton(state),
                      const AppSpacer(
                        height: AppValues.height_16,
                      ),
                      _buildSignInWith(context),
                      const AppSpacer(
                        height: AppValues.height_16,
                      ),
                      _buildSocialLogIn(context),
                      _buildDontHaveAccount(),
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
      AppAssets.logoNoBackGroundPng,
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

  Widget _buildResetPasswordButton(SignInState state) {
    return state.status == SignInStatus.loading
        ? const SpinKitFadingCircle(color: Colors.blue)
        : AppPrimaryButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<SignInBloc>().add(
                      ResetPasswordSubmitted(
                        password: _passwordController.text,
                      ),
                    );
              }
            },
            title: "Reset Password");
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

  Widget _buildPasswordTextField(SignInState state) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: const Padding(
        padding: EdgeInsets.only(left: AppValues.margin_2),
        child: Text(
          "Enter you new password",
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(
          top: AppValues.smallMargin,
        ),
        child: AppTextField(
            contentPadding: const EdgeInsets.all(8.0),
            border: const OutlineInputBorder(),
            enabled: state.status != SignInStatus.loading,
            prefix: const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.password_outlined),
            ),
            textController: _passwordController,
            labelText: "Enter new Password",
            onChanged: (value) {
              context
                  .read<SignInBloc>()
                  .add(PasswordChangeEvent(password: value.toString()));
            },
            // validator: InputValidators.password,
            obscureText: true),
      ),
    );
  }
}
