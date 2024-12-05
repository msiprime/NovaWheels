import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/core/base_component/image_picker_bloc/image_picker_bloc.dart';
import 'package:nova_wheels/core/datasource/core_datasource.dart';

class UserProfileImageUrlGenWidget extends StatefulWidget {
  const UserProfileImageUrlGenWidget({
    super.key,
    required this.onImageUploaded,
    this.imageUrl,
  });

  final String? imageUrl;

  final Function(String? imageUrl) onImageUploaded;

  @override
  State<UserProfileImageUrlGenWidget> createState() =>
      _StoreProfileImageUrlGeneratorWidgetState();
}

class _StoreProfileImageUrlGeneratorWidgetState
    extends State<UserProfileImageUrlGenWidget> {
  late final ImagePickerBloc imagePickerBloc;

  @override
  void initState() {
    imagePickerBloc = ImagePickerBloc(imageType: ImageType.userAvatar);
    super.initState();
  }

  @override
  void dispose() {
    imagePickerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImagePickerBloc, ImagePickerState>(
      listener: (context, state) {
        if (state is ImagePickerError) {
          context.showSnackBar(state.message);
        }
        if (state is ImageUploadedToSupabase) {
          widget.onImageUploaded(state.imageUrl);
        }
      },
      builder: (context, state) {
        final String? currentImageUrl = (state is ImageUploadedToSupabase)
            ? state.imageUrl
            : widget.imageUrl;
        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (state is ImagePickerInitial || state is ImagePickerLoading)
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  child: currentImageUrl != null && currentImageUrl.isNotEmpty
                      ? ClipOval(
                          child: ImageAttachmentThumbnail(
                            imageUrl: currentImageUrl,
                          ),
                        )
                      : const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.grey,
                        ),
                ),
              if (state is ImageUploadedToSupabase) ...[
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  child: ClipOval(
                      child:
                          ImageAttachmentThumbnail(imageUrl: state.imageUrl)),
                ),
              ],
              if (state is ImagePickerLoading ||
                  state is UploadingImageToSupabase ||
                  state is RemovingImageFromSupabase)
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),
                ),
              if (state is ImagePickerInitial || state is ImagePickerLoading)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Tappable.scaled(
                    onTap: () {
                      imagePickerBloc.add(
                        PickImageEvent(
                          fileName:
                              'user_profile_${DateTime.now().millisecondsSinceEpoch}',
                        ),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15,
                      child: Icon(
                        Icons.add_a_photo,
                        size: 18,
                        color: context.theme.primaryColor,
                      ),
                    ),
                  ),
                ),
              if (state is ImageUploadedToSupabase)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Tappable.scaled(
                    onTap: () {
                      imagePickerBloc.add(RemoveImageEvent());
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.8),
                      radius: 15,
                      child: Icon(
                        Icons.delete_forever_outlined,
                        size: 20,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
      bloc: imagePickerBloc,
    );
  }
}
