import 'package:nova_wheels/features/vehicle/domain/entities/image_entity.dart';
import 'package:nova_wheels/shared/utils/mapper/base_mapper.dart';

class ImagesModel implements BaseMapper<ImageEntity> {
  String? coverPhoto;

  ImagesModel({this.coverPhoto});

  ImagesModel.fromJson(Map<String, dynamic> json) {
    coverPhoto = json['cover photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cover photo'] = coverPhoto;
    return data;
  }

  @override
  ImageEntity mapToEntity() {
    return ImageEntity(coverPhoto: coverPhoto);
  }
}
