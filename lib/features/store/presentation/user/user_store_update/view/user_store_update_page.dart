import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:nova_wheels/config/sl/injection_container.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_bar.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_primary_button.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/domain/use_cases/delete_store_usecase.dart';
import 'package:nova_wheels/features/store/domain/use_cases/fetch_store_by_id_usecase.dart';
import 'package:nova_wheels/features/store/domain/use_cases/fetch_user_store_usecase.dart';
import 'package:nova_wheels/features/store/domain/use_cases/update_store_usecase.dart';
import 'package:nova_wheels/features/store/presentation/user/user_store_fetch/bloc/user_store_fetch_bloc.dart';
import 'package:nova_wheels/features/store/presentation/user/user_store_update/bloc/update_store_bloc.dart';
import 'package:nova_wheels/features/store/shared/widget/store_cover_image_url_gen_widget.dart';
import 'package:nova_wheels/features/store/shared/widget/store_profile_image_url_gen_widget.dart';

class UserStoreUpdatePage extends StatelessWidget {
  static const String routeName = 'user-store-update';

  const UserStoreUpdatePage({super.key, required this.storeId});

  final String storeId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UpdateStoreBloc>(
          create: (context) => UpdateStoreBloc(
            updateStoreUseCase: sl.call<UpdateStoreUseCase>(),
            deleteStoreUseCase: sl.call<DeleteStoreUseCase>(),
          ),
        ),
        BlocProvider<UserStoreFetchBloc>(
          create: (context) => UserStoreFetchBloc(
            fetchUserStoreByIdUseCase: sl.call<FetchUserStoreByIdUseCase>(),
            fetchUserStoreUseCase: sl.call<FetchUserStoreUseCase>(),
          ),
        ),
      ],
      child: UpdateStoreView(
        storeId: storeId,
      ),
    );
  }
}

class UpdateStoreView extends StatefulWidget {
  const UpdateStoreView({super.key, required this.storeId});

  final String storeId;

  @override
  State<UpdateStoreView> createState() => _UpdateStoreViewState();
}

class _UpdateStoreViewState extends State<UpdateStoreView> {
  @override
  void initState() {
    context
        .read<UserStoreFetchBloc>()
        .add(UserStoreByIdFetched(widget.storeId));

    initTextFormControllers();
    _formKey = GlobalKey<FormState>();
    _loadingOverlay = OverlayEntry(
      builder: (context) => Center(
        child: CupertinoActivityIndicator(
          radius: 12,
        ),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    disposeTextFormControllers();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  late final GlobalKey<FormState> _formKey;
  late OverlayEntry _loadingOverlay;

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
    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<UserStoreFetchBloc>()
            .add(UserStoreByIdFetched(widget.storeId));
      },
      child: AppScaffold(
        appBar: NovaWheelsAppBar(title: 'Update Store'),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: BlocConsumer<UserStoreFetchBloc, UserStoreFetchState>(
              listener: (context, state) {
                if (state is UserStoreFetchSuccess) {
                  _storeCoverImageUrl = state.stores.first.coverImage ?? '';
                  _storeProfileImageUrl =
                      state.stores.first.profilePicture ?? '';
                  _populateTextControllers(state.stores.first);
                  if (_loadingOverlay.mounted) {
                    _loadingOverlay.remove();
                  }
                }
                if (state is UserStoreFetchFailure) {
                  if (_loadingOverlay.mounted) {
                    _loadingOverlay.remove();
                  }
                  context.showSnackBar(
                    state.errorMessage,
                  );
                }
                if (state is UserStoreFetchLoading) {
                  Overlay.of(context).insert(_loadingOverlay);
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            StoreCoverImageUrlGenWidget(
                              imageUrl: state is UserStoreFetchSuccess
                                  ? state.stores.first.coverImage
                                  : null,
                              onImageUploaded: (imageUrl) {
                                _storeCoverImageUrl = imageUrl ?? '';
                              },
                            ),
                            const Gap(50),
                          ],
                        ),
                        Positioned(
                          left: 16,
                          bottom: 0,
                          child: StoreProfileImageUrlGeneratorWidget(
                            imageUrl: state is UserStoreFetchSuccess
                                ? state.stores.first.profilePicture
                                : null,
                            onImageUploaded: (imageUrl) {
                              _storeProfileImageUrl = imageUrl ?? '';
                            },
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    _UpdateForm(
                      formKey: _formKey,
                      isLoading: state is UserStoreFetchLoading,
                      storeNameController: _storeNameController,
                      storeDescriptionController: _storeDescriptionController,
                      storeAddressController: _storeAddressController,
                      storePhoneNumController: _storePhoneNumController,
                      storeEmailController: _storeEmailController,
                      storeFacebookController: _storeFacebookController,
                      storeInstagramController: _storeInstagramController,
                      storeTwitterController: _storeTwitterController,
                      storeWebsiteController: _storeWebsiteController,
                    ),
                    const Gap(20),
                    BlocConsumer<UpdateStoreBloc, UpdateStoreState>(
                      listener: (context, state) {
                        if (state is UpdateStoreSuccess) {
                          context.showSnackBar(
                            'Successfully Updated',
                            behavior: SnackBarBehavior.floating,
                            color: Colors.green,
                          );
                        }
                        if (state is UpdateStoreError) {
                          context.showSnackBar(
                            state.errorMessage,
                            behavior: SnackBarBehavior.floating,
                            color: Colors.red,
                          );
                        }
                      },
                      builder: (context, state) {
                        return AppPrimaryButton(
                            isLoading: state is UpdateStoreLoading,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.confirmAction(
                                    fn: () {
                                      context.read<UpdateStoreBloc>().add(
                                            UpdateStorePressed(
                                              storeEntity: StoreEntity(
                                                id: widget.storeId,
                                                name: _storeNameController.text,
                                                description:
                                                    _storeDescriptionController
                                                        .text,
                                                address: _storeAddressController
                                                    .text,
                                                phoneNumber:
                                                    _storePhoneNumController
                                                        .text,
                                                email:
                                                    _storeEmailController.text,
                                                facebook:
                                                    _storeFacebookController
                                                        .text,
                                                instagram:
                                                    _storeInstagramController
                                                        .text,
                                                twitter: _storeTwitterController
                                                    .text,
                                                website: _storeWebsiteController
                                                    .text,
                                                coverImage: _storeCoverImageUrl,
                                                profilePicture:
                                                    _storeProfileImageUrl,
                                              ),
                                            ),
                                          );
                                    },
                                    title: 'Update Confirmation',
                                    content:
                                        'Are you sure you want to update this store?',
                                    noText: 'Cancel',
                                    yesText: 'Update');
                              }
                            },
                            title: 'Update Store');
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// populate data
  void _populateTextControllers(StoreEntity store) {
    _storeNameController.text = store.name;
    _storeDescriptionController.text = store.description ?? '';
    _storeAddressController.text = store.address ?? '';
    _storePhoneNumController.text = store.phoneNumber ?? '';
    _storeEmailController.text = store.email ?? '';
    _storeFacebookController.text = store.facebook ?? '';
    _storeInstagramController.text = store.instagram ?? '';
    _storeTwitterController.text = store.twitter ?? '';
    _storeWebsiteController.text = store.website ?? '';
  }

  ///init and dispose thy shit
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

class _UpdateForm extends StatelessWidget {
  const _UpdateForm({
    required GlobalKey<FormState> formKey,
    required TextEditingController storeNameController,
    required TextEditingController storeDescriptionController,
    required TextEditingController storeAddressController,
    required TextEditingController storePhoneNumController,
    required TextEditingController storeEmailController,
    required TextEditingController storeFacebookController,
    required TextEditingController storeInstagramController,
    required TextEditingController storeTwitterController,
    required TextEditingController storeWebsiteController,
    required bool isLoading,
  })  : _formKey = formKey,
        _isLoading = isLoading,
        _storeNameController = storeNameController,
        _storeDescriptionController = storeDescriptionController,
        _storeAddressController = storeAddressController,
        _storePhoneNumController = storePhoneNumController,
        _storeEmailController = storeEmailController,
        _storeFacebookController = storeFacebookController,
        _storeInstagramController = storeInstagramController,
        _storeTwitterController = storeTwitterController,
        _storeWebsiteController = storeWebsiteController;

  final bool _isLoading;
  final GlobalKey<FormState> _formKey;
  final TextEditingController _storeNameController;
  final TextEditingController _storeDescriptionController;
  final TextEditingController _storeAddressController;
  final TextEditingController _storePhoneNumController;
  final TextEditingController _storeEmailController;
  final TextEditingController _storeFacebookController;
  final TextEditingController _storeInstagramController;
  final TextEditingController _storeTwitterController;
  final TextEditingController _storeWebsiteController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Store Name',
            style: context.titleSmall,
          ),
          const Gap(5),
          AppTextField.roundedBorder(
            isLoading: _isLoading,
            controller: _storeNameController,
            hintText: 'Store Name',
          ),
          const Gap(10),
          Text(
            'Store Description',
            style: context.titleSmall,
          ),
          const Gap(5),
          AppTextField.roundedBorder(
            isLoading: _isLoading,
            controller: _storeDescriptionController,
            hintText: 'Store Description',
          ),
          const Gap(10),
          Text(
            'Store Address',
            style: context.titleSmall,
          ),
          const Gap(5),
          AppTextField.roundedBorder(
            isLoading: _isLoading,
            controller: _storeAddressController,
            hintText: 'Store Address',
          ),
          const Gap(10),
          Text(
            'Store Phone Number',
            style: context.titleSmall,
          ),
          const Gap(5),
          AppTextField.roundedBorder(
            isLoading: _isLoading,
            controller: _storePhoneNumController,
            hintText: 'Store Phone Number',
          ),
          const Gap(10),
          Text(
            'Store Email',
            style: context.titleSmall,
          ),
          const Gap(5),
          AppTextField.roundedBorder(
            isLoading: _isLoading,
            controller: _storeEmailController,
            hintText: 'Store Email',
          ),
          const Gap(10),
          Text(
            'Store Facebook',
            style: context.titleSmall,
          ),
          const Gap(5),
          AppTextField.roundedBorder(
            isLoading: _isLoading,
            controller: _storeFacebookController,
            hintText: 'Store Facebook',
          ),
          const Gap(10),
          Text(
            'Store Instagram',
            style: context.titleSmall,
          ),
          const Gap(5),
          AppTextField.roundedBorder(
            isLoading: _isLoading,
            controller: _storeInstagramController,
            hintText: 'Store Instagram',
          ),
          const Gap(10),
          Text(
            'Store Twitter',
            style: context.titleSmall,
          ),
          const Gap(5),
          AppTextField.roundedBorder(
            isLoading: _isLoading,
            controller: _storeTwitterController,
            hintText: 'Store Twitter',
          ),
          const Gap(10),
          Text(
            'Store Website',
            style: context.titleSmall,
          ),
          const Gap(5),
          AppTextField.roundedBorder(
            isLoading: _isLoading,
            controller: _storeWebsiteController,
            hintText: 'Store Website',
          ),
        ],
      ),
    );
  }
}
