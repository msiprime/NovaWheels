import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/core/base_component/image_picker_bloc/image_picker_bloc.dart';
import 'package:nova_wheels/core/datasource/core_datasource.dart';

class StoreCoverImageUrlGenWidget extends StatefulWidget {
  const StoreCoverImageUrlGenWidget({
    super.key,
    required this.onImageUploaded,
  });

  final Function(String? imageUrl) onImageUploaded;

  @override
  State<StoreCoverImageUrlGenWidget> createState() =>
      _StoreCoverImageUrlGenWidgetState();
}

class _StoreCoverImageUrlGenWidgetState
    extends State<StoreCoverImageUrlGenWidget> {
  late final ImagePickerBloc storeCoverImageBloc;

  @override
  void initState() {
    storeCoverImageBloc = ImagePickerBloc(imageType: ImageType.storeCover);
    super.initState();
  }

  @override
  void dispose() {
    storeCoverImageBloc.close();
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
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[400],
                  // image: state is ImageUploadedToSupabase
                  //     ? DecorationImage(
                  //         image: NetworkImage(
                  //           state.imageUrl,
                  //         ),
                  //         fit: BoxFit.cover,
                  //       )
                  //     : null,
                ),
                child: state is ImageUploadedToSupabase
                    ? ImageAttachmentThumbnail(imageUrl: state.imageUrl)
                    : Center(
                        child: Icon(
                          Icons.image,
                          size: 60,
                          color: Colors.grey[600],
                        ),
                      ),
              ),
              if (state is ImagePickerLoading ||
                  state is UploadingImageToSupabase ||
                  state is RemovingImageFromSupabase)
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    ),
                  ),
                ),
              if (state is ImagePickerInitial || state is ImagePickerLoading)
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Tappable.scaled(
                    onTap: () {
                      storeCoverImageBloc.add(PickImageEvent(
                        fileName:
                            'cover_image_${DateTime.now().millisecondsSinceEpoch}',
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
                  top: 10,
                  right: 10,
                  child: Tappable.scaled(
                    onTap: () {
                      storeCoverImageBloc.add(RemoveImageEvent());
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
      bloc: storeCoverImageBloc,
    );
  }
}
