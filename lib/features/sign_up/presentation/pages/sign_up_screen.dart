import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_primary_button.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_spacer.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_textfield.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/base_setting_row.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:nova_wheels/shared/utils/utils.dart';
import 'package:nova_wheels/shared/validators/input_validators.dart';
import 'package:nova_wheels/shared/values/app_assets_path.dart';
import 'package:nova_wheels/shared/values/app_colors.dart';
import 'package:nova_wheels/shared/values/app_values.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late AppLocalizations? _appLocalizations;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state.status == SignUpStatus.success) {
            _fullNameController.text = '';
            _passwordController.text = '';
            _birthDateController.text = '';
            _emailController.text = '';
            _phoneNumberController.text = '';
            _confirmPasswordController.text = '';
            showSnackBarMessage(
              context,
              state.responseMessage,
              SnackBarMessageType.success,
            );
            context.read<SignUpBloc>().add(SignUpStatusChange());
          } else if (state.status == SignUpStatus.failure) {
            showSnackBarMessage(
                context, state.errorMessage, SnackBarMessageType.failure);
          } else if (state.status == SignUpStatus.verifyOTP) {
            showSnackBarMessage(
                context, state.responseMessage, SnackBarMessageType.success);
            context.goNamed(Routes.verifyOtp);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const ChangeSetting(),
                        const SizedBox(
                          height: AppValues.halfPadding,
                        ),
                        _buildAppHeader(),
                        const SizedBox(
                          height: AppValues.halfPadding,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildFullNameField(),
                            const SizedBox(
                              width: AppValues.margin,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: AppValues.halfPadding,
                        ),
                        _buildEmailField(),
                        const SizedBox(
                          height: AppValues.halfPadding,
                        ),
                        _buildPhoneNumberField(),
                        const SizedBox(
                          height: AppValues.halfPadding,
                        ),
                        _buildPasswordTextField(),
                        const SizedBox(
                          height: AppValues.padding,
                        ),
                        _buildConfirmPasswordTextField(),
                        const SizedBox(
                          height: AppValues.padding,
                        ),
                        _buildSubmitButton(state),
                        const SizedBox(
                          height: AppValues.padding,
                        ),
                        _buildCreateAccountWith(context),
                        const SizedBox(
                          height: AppValues.halfPadding,
                        ),
                        _buildSocialLogIn(context),
                        _buildFooter(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCreateAccountWith(BuildContext context) {
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
                child: Text(_appLocalizations?.orCreateAccountWith ?? "")),
          ),
          const Flexible(
            flex: 1,
            child: Divider(),
          ),
        ],
      ),
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
          const AppSpacer(
            width: AppValues.padding,
          ),
          IconButton(
            icon: SvgPicture.asset(AppAssets.facebookSVG),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildFullNameField() {
    return Flexible(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Padding(
          padding: const EdgeInsets.only(left: AppValues.margin_2),
          child: Text(
            _appLocalizations?.fullNameFormTitle ?? "",
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: AppValues.smallMargin),
          child: AppTextField(
            onChanged: (value) {
              context.read<SignUpBloc>().add(
                    FirstNameChangeEvent(
                      firstName: value ?? "",
                    ),
                  );
            },
            controller: _fullNameController,
            validator: InputValidators.name,
            labelText: _appLocalizations?.fullNameFormLabel ?? "",
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(left: AppValues.margin_2),
        child: Text(
          _appLocalizations?.fieldLabelTextEmail ?? "",
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: AppValues.smallMargin),
        child: AppTextField(
            onChanged: (value) {
              context.read<SignUpBloc>().add(
                    EmailChangeEvent(
                      email: value ?? "",
                    ),
                  );
            },
            controller: _emailController,
            validator: InputValidators.email,
            labelText: _appLocalizations?.emailLabel ?? "",
            prefix: const Icon(Icons.email_outlined)),
      ),
    );
  }

  Widget _buildAppHeader() {
    return Image.asset(
      AppAssets.circleLogoNoBackGroundPng,
      width: 220,
    );
  }

  Widget _buildPhoneNumberField() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(left: AppValues.margin_2),
        child: Text(
          _appLocalizations?.fieldLabelTextPhone ?? "",
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: AppValues.smallMargin),
        child: AppTextField(
          onChanged: (value) {
            context.read<SignUpBloc>().add(
                  PhoneNumberChangeEvent(
                    phoneNumber: value ?? "",
                  ),
                );
          },
          controller: _phoneNumberController,
          validator: InputValidators.phone,
          labelText: _appLocalizations?.phoneLabel ?? "",
          prefix: const Icon(Icons.phone_iphone_outlined),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(left: AppValues.margin_2),
        child: Text(
          _appLocalizations?.fieldTitlePassword ?? "",
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(
          top: AppValues.smallMargin,
        ),
        child: AppTextField(
            prefix: const Icon(Icons.password_outlined),
            controller: _passwordController,
            labelText: _appLocalizations?.fieldLabelTextPassword ?? "",
            onChanged: (value) {
              context
                  .read<SignUpBloc>()
                  .add(PasswordChangeEvent(password: value.toString()));
            },
            validator: InputValidators.password,
            obscureText: true),
      ),
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(left: AppValues.margin_2),
        child: Text(
          "Confirm Password",
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(
          top: AppValues.smallMargin,
        ),
        child: AppTextField(
            prefix: const Icon(Icons.password_outlined),
            controller: _confirmPasswordController,
            labelText: "Retype your password",
            onChanged: (value) {
              context
                  .read<SignUpBloc>()
                  .add(PasswordChangeEvent(password: value.toString()));
            },
            validator: (value) {
              return InputValidators.confirmPassword(
                  value, _passwordController.text);
            },
            obscureText: true),
      ),
    );
  }

  Widget _buildSubmitButton(SignUpState state) {
    return state.status == SignUpStatus.loading
        ? const Center(
            child: CircularProgressIndicator(
              color: AppColorsMain.colorPrimary,
            ),
          )
        : AppPrimaryButton(
            onPressed: () => {
              if (_formKey.currentState!.validate())
                {
                  context.read<SignUpBloc>().add(SignUpSubmitted()),
                }
            },
            title: _appLocalizations?.signUp ?? "",
          );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_appLocalizations?.alreadyHaveAccount ?? ""),
        const SizedBox(
          width: AppValues.halfPadding,
        ),
        TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(_appLocalizations?.logIn ?? ""))
      ],
    );
  }
}
