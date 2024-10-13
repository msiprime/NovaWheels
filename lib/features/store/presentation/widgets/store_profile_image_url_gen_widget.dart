import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/core/base_component/image_picker_bloc/image_picker_bloc.dart';
import 'package:nova_wheels/core/datasource/core_datasource.dart';

class StoreProfileImageUrlGeneratorWidget extends StatefulWidget {
  const StoreProfileImageUrlGeneratorWidget({
    super.key,
    required this.onImageUploaded,
  });

  final Function(String? imageUrl) onImageUploaded;

  @override
  State<StoreProfileImageUrlGeneratorWidget> createState() =>
      _StoreProfileImageUrlGeneratorWidgetState();
}

class _StoreProfileImageUrlGeneratorWidgetState
    extends State<StoreProfileImageUrlGeneratorWidget> {
  late final ImagePickerBloc storeProfileImageBloc;

  @override
  void initState() {
    storeProfileImageBloc = ImagePickerBloc(imageType: ImageType.storeProfile);
    super.initState();
  }

  @override
  void dispose() {
    storeProfileImageBloc.close();
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
        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (state is ImagePickerInitial)
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.black54,
                  child: state is! ImageUploadedToSupabase
                      ? Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey[400],
                        )
                      : null,
                ),
              if (state is ImageUploadedToSupabase) ...[
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[200],
                  child: ClipOval(
                      child:
                          ImageAttachmentThumbnail(imageUrl: state.imageUrl)),
                ),
              ],
              if (state is ImagePickerLoading)
                Container(
                  width: 120,
                  height: 120,
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
              if (state is UploadingImageToSupabase ||
                  state is RemovingImageFromSupabase)
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    ),
                  ),
                ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Tappable.scaled(
                  onTap: () {
                    storeProfileImageBloc.add(PickImageEvent(
                        // imageType: ImageType.storeProfile,
                        ));
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 18,
                    child: Icon(
                      Icons.add_a_photo,
                      size: 20,
                      color: context.theme.primaryColor,
                    ),
                  ),
                ),
              ),
              if (state is ImageUploadedToSupabase)
                Positioned(
                  bottom: -10,
                  left: 10,
                  child: Tappable.scaled(
                    onTap: () {
                      storeProfileImageBloc.add(RemoveImageEvent());
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 18,
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
      bloc: storeProfileImageBloc,
    );
  }
}
