import 'dart:io';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_bar.dart';
import 'package:nova_wheels/features/store/presentation/widgets/avatar_image_url_gen_widget.dart';
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

  File? _imageFile;

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
              const Gap(16),
              AvatarImageUrlGeneratorWidget(
                onImageUploaded: (imageUrl) {
                  Log.info('imageUrl: $imageUrl');
                },
              ),
              const Gap(10),
              Center(
                child: Text(
                  'store profile picture',
                  style: context.titleSmall,
                ),
              ),
              const Gap(16),
              _buildStoreNameTF(),
              const Gap(16),
              _buildStoreDescriptionTF(),
              const Gap(16),
              _buildStoreAddressTF(),
              const Gap(16),
              _buildStorePhoneNumTF(),
              const Gap(16),
              _buildStoreEmailTF(),
              const Gap(16),
              _buildStoreFacebookTF(),
              const Gap(16),
              _buildInstagramTF(),
              const Gap(16),
              _buildStoreTwitterTF(),
              const Gap(16),
              _buildStoreWebsiteTF(),
              const Gap(16),
              Tappable.faded(
                  borderRadius: 8,
                  backgroundColor: Colors.red,
                  fadeStrength: FadeStrength.lg,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Examining bullshit '),
                  ),
                  onTap: () async {}),
            ],
          ),
        ),
      ),
    );
  }

  AppTextField _buildStorePhoneNumTF() {
    return AppTextField.roundedBorder(
      textController: _storePhoneNumController,
      labelText: 'Store Phone Number',
      validator: (p0) => InputValidators.phone(p0),
    );
  }

  AppTextField _buildStoreEmailTF() {
    return AppTextField.roundedBorder(
      textController: _storeEmailController,
      labelText: 'Store Email Address',
    );
  }

  AppTextField _buildStoreFacebookTF() {
    return AppTextField.roundedBorder(
      textController: _storeFacebookController,
      labelText: 'Store Facebook Page',
    );
  }

  AppTextField _buildInstagramTF() {
    return AppTextField.roundedBorder(
      textController: _storeInstagramController,
      labelText: 'Store Instagram Page',
    );
  }

  AppTextField _buildStoreTwitterTF() {
    return AppTextField.roundedBorder(
      textController: _storeTwitterController,
      labelText: 'Store Twitter Page',
    );
  }

  AppTextField _buildStoreWebsiteTF() {
    return AppTextField.roundedBorder(
      textController: _storeWebsiteController,
      labelText: 'Store Website',
    );
  }

  AppTextField _buildStoreAddressTF() {
    return AppTextField.roundedBorder(
      textController: _storeAddressController,
      labelText: 'Store Address',
    );
  }

  AppTextField _buildStoreDescriptionTF() {
    return AppTextField.roundedBorder(
      textController: _storeDescriptionController,
      labelText: 'Store Description',
    );
  }

  AppTextField _buildStoreNameTF() {
    return AppTextField.roundedBorder(
      textController: _storeNameController,
      labelText: 'Store Name',
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
