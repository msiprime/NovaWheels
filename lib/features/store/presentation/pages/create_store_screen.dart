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
                alignment: Alignment.bottomLeft, // Align to bottom right
                children: [
                  // Cover Image Widget
                  StoreCoverImageUrlGenWidget(
                    onImageUploaded: (imageUrl) {
                      Log.info('Cover imageUrl: $imageUrl');
                    },
                  ),
                  // Profile Image Widget
                  Positioned(
                    left: 16,
                    bottom: 16, // Positioning the profile picture
                    child: StoreProfileImageUrlGeneratorWidget(
                      onImageUploaded: (imageUrl) {
                        Log.info('Profile imageUrl: $imageUrl');
                      },
                    ),
                  ),
                ],
              ),
              const Gap(16),
              Center(
                child: Text(
                  'Store Profile Picture',
                  style: context.titleSmall,
                ),
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

  Text _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  AppTextField _buildStorePhoneNumTF() {
    return AppTextField.roundedBorder(
      textController: _storePhoneNumController,
      labelText: 'Phone Number',
      validator: (p0) => InputValidators.phone(p0),
    );
  }

  AppTextField _buildStoreEmailTF() {
    return AppTextField.roundedBorder(
      textController: _storeEmailController,
      labelText: 'Email Address',
    );
  }

  AppTextField _buildStoreFacebookTF() {
    return AppTextField.roundedBorder(
      textController: _storeFacebookController,
      labelText: 'Facebook Page',
    );
  }

  AppTextField _buildInstagramTF() {
    return AppTextField.roundedBorder(
      textController: _storeInstagramController,
      labelText: 'Instagram Page',
    );
  }

  AppTextField _buildStoreTwitterTF() {
    return AppTextField.roundedBorder(
      textController: _storeTwitterController,
      labelText: 'Twitter Page',
    );
  }

  AppTextField _buildStoreWebsiteTF() {
    return AppTextField.roundedBorder(
      textController: _storeWebsiteController,
      labelText: 'Website',
    );
  }

  AppTextField _buildStoreAddressTF() {
    return AppTextField.roundedBorder(
      textController: _storeAddressController,
      labelText: 'Address',
    );
  }

  AppTextField _buildStoreDescriptionTF() {
    return AppTextField.roundedBorder(
      textController: _storeDescriptionController,
      labelText: 'Description',
    );
  }

  AppTextField _buildStoreNameTF() {
    return AppTextField.roundedBorder(
      textController: _storeNameController,
      labelText: 'Name',
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
