import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/config/sl/injection_container.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_bar.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_primary_button.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/store/domain/params/store_creation_params.dart';
import 'package:nova_wheels/features/store/domain/use_cases/create_store_usecase.dart';
import 'package:nova_wheels/features/store/presentation/blocs/create_store_bloc/create_store_bloc.dart';
import 'package:nova_wheels/features/store/presentation/widgets/store_cover_image_url_gen_widget.dart';
import 'package:nova_wheels/features/store/presentation/widgets/store_profile_image_url_gen_widget.dart';
import 'package:nova_wheels/shared/utils/logger.dart';
import 'package:nova_wheels/shared/validators/input_validators.dart';

class CreateStoreScreen extends StatefulWidget {
  const CreateStoreScreen({super.key});

  @override
  State<CreateStoreScreen> createState() => _CreateStoreScreenState();
}

class _CreateStoreScreenState extends State<CreateStoreScreen> {
  // late final CreateStoreCubit _createStoreCubit;

  @override
  void initState() {
    initTextFormControllers();
    _formKey = GlobalKey<FormState>();

    super.initState();
  }

  @override
  void dispose() {
    disposeTextFormControllers();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _storeNameController;
  late final TextEditingController _storeDescriptionController;
  late final TextEditingController _storeAddressController;
  late final TextEditingController _storePhoneNumController;
  late final TextEditingController _storeEmailController;
  late final TextEditingController _storeFacebookController;
  late final TextEditingController _storeInstagramController;
  late final TextEditingController _storeTwitterController;
  late final TextEditingController _storeWebsiteController;

  String _storeCoverImageUrl = '';
  String _storeProfileImageUrl = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CreateStoreBloc(createStoreUseCase: sl.get<CreateStoreUseCase>()),
      child: AppScaffold(
        releaseFocus: true,
        appBar: NovaWheelsAppBar(
          title: 'Create Store',
        ),
        safeArea: true,
        body: BlocConsumer<CreateStoreBloc, CreateStoreState>(
          listener: (context, state) {
            if (state is CreateStoreSuccess) {
              context.showSnackBar('Store Created Successfully',
                  color: Colors.green);
              context.goNamed(Routes.store);
            } else if (state is CreateStoreFailure) {
              context.showSnackBar(
                state.errorMessage,
                color: Colors.red,
              );
            }
          },
          builder: (context, state) {
            final bool isLoading = state is CreateStoreLoading;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Column(
                            children: [
                              StoreCoverImageUrlGenWidget(
                                onImageUploaded: (imageUrl) {
                                  _storeCoverImageUrl = imageUrl ?? '';
                                  Log.info(
                                      'Profile Image URL: $_storeCoverImageUrl');
                                },
                              ),
                              const Gap(50),
                            ],
                          ),
                          Positioned(
                            left: 16,
                            bottom: 0,
                            child: StoreProfileImageUrlGeneratorWidget(
                              onImageUploaded: (imageUrl) {
                                _storeProfileImageUrl = imageUrl ?? '';
                                Log.info(
                                    'Profile Image URL: $_storeProfileImageUrl');
                              },
                            ),
                          ),
                        ],
                      ),
                      const Gap(16),
                      _buildLabel('Store Name'),
                      _buildStoreNameTF(isLoading),
                      const Gap(16),
                      _buildLabel('Store Description'),
                      _buildStoreDescriptionTF(isLoading),
                      const Gap(16),
                      _buildLabel('Store Address'),
                      _buildStoreAddressTF(isLoading),
                      const Gap(16),
                      _buildLabel('Store Phone Number'),
                      _buildStorePhoneNumTF(isLoading),
                      const Gap(16),
                      _buildLabel('Store Email Address'),
                      _buildStoreEmailTF(isLoading),
                      const Gap(16),
                      _buildLabel('Store Facebook Page'),
                      _buildStoreFacebookTF(isLoading),
                      const Gap(16),
                      _buildLabel('Store Instagram Page'),
                      _buildInstagramTF(isLoading),
                      const Gap(16),
                      _buildLabel('Store Twitter Page'),
                      _buildStoreTwitterTF(isLoading),
                      const Gap(16),
                      _buildLabel('Store Website'),
                      _buildStoreWebsiteTF(isLoading),
                      const Gap(16),
                      Center(
                        child: AppPrimaryButton(
                          isLoading: isLoading,
                          title: 'Create Store',
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<CreateStoreBloc>().add(
                                    CreateStoreTapped(
                                      storeCreationParams: StoreCreationParams(
                                        name: _storeNameController.text,
                                        email: _storeEmailController.text,
                                        phoneNumber:
                                            _storePhoneNumController.text,
                                        address: _storeAddressController.text,
                                        coverImage: _storeCoverImageUrl,
                                        description:
                                            _storeDescriptionController.text,
                                        facebook: _storeFacebookController.text,
                                        instagram:
                                            _storeInstagramController.text,
                                        profilePicture: _storeProfileImageUrl,
                                        website: _storeWebsiteController.text,
                                      ),
                                    ),
                                  );
                            }
                          },
                        ),
                      ),
                      const Gap(16),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(text, style: context.titleMedium),
    );
  }

  AppTextField _buildStorePhoneNumTF(bool loadingState) {
    return AppTextField.roundedBorder(
      enabled: !loadingState,
      textController: _storePhoneNumController,
      hintText: 'e.g +88 01712345678',
      hintStyle: context.titleMedium?.copyWith(
        color: Colors.grey,
      ),
      validator: (p0) => InputValidators.phone(p0),
    );
  }

  AppTextField _buildStoreEmailTF(bool isTextFieldEnabled) {
    return AppTextField.roundedBorder(
      enabled: !isTextFieldEnabled,
      textController: _storeEmailController,
      hintText: 'e.g msisakib958@gmail.com',
      hintStyle: context.titleMedium?.copyWith(
        color: Colors.grey,
      ),
    );
  }

  AppTextField _buildStoreFacebookTF(bool isTextFieldEnabled) {
    return AppTextField.roundedBorder(
      enabled: !isTextFieldEnabled,
      textController: _storeFacebookController,
      hintText: 'e.g www.facebook.com/msisakib958',
      hintStyle: context.titleMedium?.copyWith(
        color: Colors.grey,
      ),
    );
  }

  AppTextField _buildInstagramTF(bool isTextFieldEnabled) {
    return AppTextField.roundedBorder(
      enabled: !isTextFieldEnabled,
      textController: _storeInstagramController,
      hintText: 'e.g www.instagram.com/msisakib958',
      hintStyle: context.titleMedium?.copyWith(
        color: Colors.grey,
      ),
    );
  }

  AppTextField _buildStoreTwitterTF(bool isTextFieldEnabled) {
    return AppTextField.roundedBorder(
      enabled: !isTextFieldEnabled,
      textController: _storeTwitterController,
      hintText: 'e.g @msisakib958',
      hintStyle: context.titleMedium?.copyWith(
        color: Colors.grey,
      ),
    );
  }

  AppTextField _buildStoreWebsiteTF(bool isTextFieldEnabled) {
    return AppTextField.roundedBorder(
      enabled: !isTextFieldEnabled,
      textController: _storeWebsiteController,
      hintText: 'e.g www.msisakib958.com',
      hintStyle: context.titleMedium?.copyWith(
        color: Colors.grey,
      ),
    );
  }

  AppTextField _buildStoreAddressTF(bool isTextFieldEnabled) {
    return AppTextField.roundedBorder(
      enabled: !isTextFieldEnabled,
      textController: _storeAddressController,
      hintText: 'e.g 123, ABC Road, XYZ City',
      hintStyle: context.titleMedium?.copyWith(
        color: Colors.grey,
      ),
    );
  }

  AppTextField _buildStoreDescriptionTF(bool isTextFieldEnabled) {
    return AppTextField.roundedBorder(
      enabled: !isTextFieldEnabled,
      textController: _storeDescriptionController,
      hintText: 'e.g Shop for all your needs',
      hintStyle: context.titleMedium?.copyWith(
        color: Colors.grey,
      ),
    );
  }

  AppTextField _buildStoreNameTF(bool isTextFieldEnabled) {
    return AppTextField.roundedBorder(
      enabled: !isTextFieldEnabled,
      textController: _storeNameController,
      hintText: 'e.g Nova Wheels',
      validator: (p0) => InputValidators.name(p0),
      hintStyle: context.titleMedium?.copyWith(
        color: Colors.grey,
      ),
    );
  }

  void initTextFormControllers() {
    _storeNameController = TextEditingController();
    _storeDescriptionController = TextEditingController();
    _storeAddressController = TextEditingController();
    _storePhoneNumController = TextEditingController();
    _storeEmailController = TextEditingController();
    _storeFacebookController = TextEditingController();
    _storeInstagramController = TextEditingController();
    _storeTwitterController = TextEditingController();
    _storeWebsiteController = TextEditingController();
  }

  void disposeTextFormControllers() {
    _storeNameController.dispose();
    _storeDescriptionController.dispose();
    _storeAddressController.dispose();
    _storePhoneNumController.dispose();
    _storeEmailController.dispose();
    _storeFacebookController.dispose();
    _storeInstagramController.dispose();
    _storeTwitterController.dispose();
    _storeWebsiteController.dispose();
  }
}
