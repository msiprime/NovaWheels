import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_bar.dart';
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
  @override
  void initState() {
    initTextFormControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeTextFormControllers();
    super.dispose();
  }

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
    return AppScaffold(
      releaseFocus: true,
      appBar: NovaWheelsAppBar(
        title: 'Create Store',
      ),
      safeArea: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
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
                          Log.info('Profile Image URL: $_storeCoverImageUrl');
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
                        Log.info('Profile Image URL: $_storeProfileImageUrl');
                      },
                    ),
                  ),
                ],
              ),
              const Gap(16),
              _buildLabel('Store Name'),
              _buildStoreNameTF(),
              const Gap(16),
              _buildLabel('Store Description'),
              _buildStoreDescriptionTF(),
              const Gap(16),
              _buildLabel('Store Address'),
              _buildStoreAddressTF(),
              const Gap(16),
              _buildLabel('Store Phone Number'),
              _buildStorePhoneNumTF(),
              const Gap(16),
              _buildLabel('Store Email Address'),
              _buildStoreEmailTF(),
              const Gap(16),
              _buildLabel('Store Facebook Page'),
              _buildStoreFacebookTF(),
              const Gap(16),
              _buildLabel('Store Instagram Page'),
              _buildInstagramTF(),
              const Gap(16),
              _buildLabel('Store Twitter Page'),
              _buildStoreTwitterTF(),
              const Gap(16),
              _buildLabel('Store Website'),
              _buildStoreWebsiteTF(),
              const Gap(16),
            ],
          ),
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

  AppTextField _buildStorePhoneNumTF() {
    return AppTextField.roundedBorder(
      textController: _storePhoneNumController,
      hintText: 'e.g +88 01712345678',
      hintStyle: context.titleMedium?.copyWith(
        color: Colors.grey,
      ),
      validator: (p0) => InputValidators.phone(p0),
    );
  }

  AppTextField _buildStoreEmailTF() {
    return AppTextField.roundedBorder(
      textController: _storeEmailController,
      hintText: 'e.g msisakib958@gmail.com',
      hintStyle: context.titleMedium?.copyWith(
        color: Colors.grey,
      ),
    );
  }

  AppTextField _buildStoreFacebookTF() {
    return AppTextField.roundedBorder(
      textController: _storeFacebookController,
      hintText: 'e.g www.facebook.com/msisakib958',
      hintStyle: context.titleMedium?.copyWith(
        color: Colors.grey,
      ),
    );
  }

  AppTextField _buildInstagramTF() {
    return AppTextField.roundedBorder(
      textController: _storeInstagramController,
      hintText: 'e.g www.instagram.com/msisakib958',
      hintStyle: context.titleMedium?.copyWith(
        color: Colors.grey,
      ),
    );
  }

  AppTextField _buildStoreTwitterTF() {
    return AppTextField.roundedBorder(
      textController: _storeTwitterController,
      hintText: 'e.g @msisakib958',
      hintStyle: context.titleMedium?.copyWith(
        color: Colors.grey,
      ),
    );
  }

  AppTextField _buildStoreWebsiteTF() {
    return AppTextField.roundedBorder(
      textController: _storeWebsiteController,
      hintText: 'e.g www.msisakib958.com',
      hintStyle: context.titleMedium?.copyWith(
        color: Colors.grey,
      ),
    );
  }

  AppTextField _buildStoreAddressTF() {
    return AppTextField.roundedBorder(
      textController: _storeAddressController,
      hintText: 'e.g 123, ABC Road, XYZ City',
      hintStyle: context.titleMedium?.copyWith(
        color: Colors.grey,
      ),
    );
  }

  AppTextField _buildStoreDescriptionTF() {
    return AppTextField.roundedBorder(
      textController: _storeDescriptionController,
      hintText: 'e.g Shop for all your needs',
      hintStyle: context.titleMedium?.copyWith(
        color: Colors.grey,
      ),
    );
  }

  AppTextField _buildStoreNameTF() {
    return AppTextField.roundedBorder(
      textController: _storeNameController,
      hintText: 'e.g Nova Wheels',
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
