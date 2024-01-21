// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:openai_dart/openai_dart.dart';
import 'package:story_teller/domain/models/abstract_dalle_model.dart';

/// A representation of DALL·E model configurations.
///
/// This class holds the settings for the DALL·E image generation model,
/// including the model variant, image quality, size, and style.
class DalleModel implements AbstractDalleModel {
  
  /// The specific DALL·E model variant.
  @override
  ImageModels model;

  /// The quality setting for the generated image.
  @override
  ImageQuality quality;

  /// The size setting for the generated image.
  @override
  ImageSize size;

  /// The style setting for the generated image.
  @override
  ImageStyle style;

  /// Constructs a new `DalleModel` with the provided settings.
  DalleModel({
    required this.model,
    required this.quality,
    required this.size,
    required this.style,
  });

  /// Creates a copy of this `DalleModel` with the given parameters, allowing
  /// for modification of specific properties while keeping others unchanged.
  ///
  /// Returns a new `DalleModel` instance with the modified settings.
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

  /// Creates a new `DalleModel` from a map of settings.
  ///
  /// Expects a map with keys corresponding to the property names (`model`,
  /// `quality`, `size`, `style`) and values as the respective setting values.
  factory DalleModel.fromMap(Map<String, dynamic> map) {
    late ImageModels model;
    late ImageQuality quality;
    late ImageStyle style;
    late ImageSize size;

    switch (map['model']) {
      case 'dall-e-2':
        model = ImageModels.dallE2;
        break;
      case 'dall-e-3':
        model = ImageModels.dallE3;
        break;
      default:
        model = ImageModels.dallE2;
        break;
    }

    switch (map['quality']) {
      case 'standard':
        quality = ImageQuality.standard;
        break;
      case 'dall-e-3':
        quality = ImageQuality.hd;
        break;
      default:
        quality = ImageQuality.standard;
        break;
    }
    switch (map['size']) {
      case '1024x1024':
        size = ImageSize.v1024x1024;
        break;
      case '1792x1024':
        size = ImageSize.v1792x1024;
        break;
      case '512x512':
        size = ImageSize.v512x512;
        break;
      default:
        size = ImageSize.v512x512;
        break;
    }
    switch (map['style']) {
      case 'natural':
        style = ImageStyle.natural;
        break;
      case 'vivid':
        style = ImageStyle.vivid;
      default:
        style = ImageStyle.natural;
        break;
    }

    return DalleModel(
      model: model,
      quality: quality,
      size: size,
      style: style,
    );
  }

  /// Creates a new `DalleModel` instance from a JSON string.
  ///
  /// The JSON should contain keys for `model`, `quality`, `size`, and `style`,
  /// with values corresponding to the respective settings.
  factory DalleModel.fromJson(String source) =>
      DalleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Returns a string representation of the `DalleModel` instance.
  ///
  /// Includes the model, quality, size, and style settings in the string.
  @override
  String toString() {
    return 'DalleModel(model: $model, quality: $quality, size: $size, style: $style)';
  }

  /// Checks for equality between two `DalleModel` instances.
  ///
  /// Returns `true` if the model, quality, size, and style settings are the same.
  @override
  bool operator ==(covariant DalleModel other) {
    if (identical(this, other)) return true;

    return other.model == model &&
        other.quality == quality &&
        other.size == size &&
        other.style == style;
  }

  /// Generates a hash code for the `DalleModel` instance.
  ///
  /// Uses the model, quality, size, and style settings for hash code generation.
  @override
  int get hashCode {
    return model.hashCode ^ quality.hashCode ^ size.hashCode ^ style.hashCode;
  }
}
