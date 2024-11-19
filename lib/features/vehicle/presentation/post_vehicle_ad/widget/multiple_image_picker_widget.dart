import 'package:app_ui/app_ui.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/core/base_component/image_picker_bloc/image_picker_bloc.dart';
import 'package:nova_wheels/core/datasource/core_datasource.dart';

class MultipleImagePickerWidget extends StatelessWidget {
  const MultipleImagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GeneralImagePicker(onImageUploaded: (imageUrl) {
            print(imageUrl);
          }),
          16.gap,
          GeneralImagePicker(onImageUploaded: (imageUrl) {
            print(imageUrl);
          }),
          16.gap,
          GeneralImagePicker(onImageUploaded: (imageUrl) {
            print(imageUrl);
          }),
          16.gap,
          GeneralImagePicker(onImageUploaded: (imageUrl) {
            print(imageUrl);
          }),
          16.gap,
          GeneralImagePicker(onImageUploaded: (imageUrl) {
            print(imageUrl);
          }),
        ],
      ),
    );
  }
}

class GeneralImagePicker extends StatefulWidget {
  const GeneralImagePicker({
    super.key,
    required this.onImageUploaded,
    this.imageUrl,
  });

  final String? imageUrl;

  final Function(String? imageUrl) onImageUploaded;

  @override
  State<GeneralImagePicker> createState() => _GeneralImagePickerState();
}

class _GeneralImagePickerState extends State<GeneralImagePicker> {
  late final ImagePickerBloc vehicleImageBloc;

  @override
  void initState() {
    vehicleImageBloc = ImagePickerBloc(imageType: ImageType.vehicleImage);
    super.initState();
  }

  @override
  void dispose() {
    vehicleImageBloc.close();
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
                SizedBox(
                  height: 80,
                  width: 80,
                  child: DottedBorder(
                    radius: const Radius.circular(12),
                    dashPattern: [6, 3],
                    padding: const EdgeInsets.all(16),
                    color: Colors.grey.shade400,
                    child: currentImageUrl != null && currentImageUrl.isNotEmpty
                        ? ImageAttachmentThumbnail(imageUrl: currentImageUrl)
                        : Icon(
                            Icons.image_outlined,
                            size: 50,
                            color: Colors.grey.shade300,
                          ),
                  ),
                ),
              if (state is ImageUploadedToSupabase) ...[
                ImageAttachmentThumbnail(
                  borderRadius: BorderRadius.circular(10),
                  imageUrl: state.imageUrl,
                  height: 80,
                  width: 80,
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
                      vehicleImageBloc.add(PickImageEvent(
                        fileName:
                            'vehicle_image_${DateTime.now().millisecondsSinceEpoch}',
                      ));
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
                      vehicleImageBloc.add(RemoveImageEvent());
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
      bloc: vehicleImageBloc,
    );
  }
}
