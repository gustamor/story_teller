// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:openai_dart/openai_dart.dart';

class DalleModel implements AbstractDalleModel {
  @override
  ImageModels model;

  @override
  ImageQuality quality;

  @override
  ImageSize size;

  @override
  ImageStyle style;
  DalleModel({
    required this.model,
    required this.quality,
    required this.size,
    required this.style,
  });

  DalleModel copyWith({
    ImageModels? model,
    ImageQuality? quality,
    ImageSize? size,
    ImageStyle? style,
  }) {
    return DalleModel(
      model: model ?? this.model,
      quality: quality ?? this.quality,
      size: size ?? this.size,
      style: style ?? this.style,
    );
  }

 

  factory DalleModel.fromMap(Map<String, dynamic> map) {
    late ImageModels _model;
    late ImageQuality _quality;
    late ImageStyle _style;
    late ImageSize _size;

    switch (map['model']) {
      case 'dall-e-2':
        _model = ImageModels.dallE2;
        break;
      case 'dall-e-3':
        _model = ImageModels.dallE3;
        break;
      default:
        _model = ImageModels.dallE2;
        break;
    }

    switch (map['quality']) {
      case 'standard':
        _quality = ImageQuality.standard;
        break;
      case 'dall-e-3':
        _quality = ImageQuality.hd;
        break;
      default:
        _quality = ImageQuality.standard;
        break;
    }
    switch (map['size']) {
      case '1024x1024':
        _size = ImageSize.v1024x1024;
        break;
      case '1792x1024':
        _size = ImageSize.v1792x1024;
        break;
      case '512x512':
        _size = ImageSize.v512x512;
        break;
      default:
        _size = ImageSize.v512x512;
        break;
    }
    switch (map['style']) {
      case 'natural':
        _style = ImageStyle.natural;
        break;
      case 'vivid':
        _style = ImageStyle.vivid;
      default:
        _style = ImageStyle.natural;
        break;
    }

    return DalleModel(
      model: _model,
      quality: _quality,
      size: _size,
      style: _style,
    );
  }


  factory DalleModel.fromJson(String source) =>
      DalleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DalleModel(model: $model, quality: $quality, size: $size, style: $style)';
  }

  @override
  bool operator ==(covariant DalleModel other) {
    if (identical(this, other)) return true;

    return other.model == model &&
        other.quality == quality &&
        other.size == size &&
        other.style == style;
  }

  @override
  int get hashCode {
    return model.hashCode ^ quality.hashCode ^ size.hashCode ^ style.hashCode;
  }
}

abstract class AbstractDalleModel {
  ImageModels model;
  ImageQuality quality;
  ImageSize size;
  ImageStyle style;

  AbstractDalleModel(
    this.model,
    this.quality,
    this.size,
    this.style,
  );

  @override
  String toString() {
    return 'AbstractDalleModel(model: $model, quality: $quality, size: $size, style: $style)';
  }

  @override
  bool operator ==(covariant AbstractDalleModel other) {
    if (identical(this, other)) return true;

    return other.model == model &&
        other.quality == quality &&
        other.size == size &&
        other.style == style;
  }

  @override
  int get hashCode {
    return model.hashCode ^ quality.hashCode ^ size.hashCode ^ style.hashCode;
  }
}
