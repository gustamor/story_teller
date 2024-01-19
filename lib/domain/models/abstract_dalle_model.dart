
import 'package:openai_dart/openai_dart.dart';

/// An abstract class representing the model for DALL-E image generation.
///
/// This class encapsulates the properties related to the model, quality,
/// size, and style of the generated images. It serves as a base for concrete
/// implementations that generate images based on these properties.
abstract class AbstractDalleModel {
  /// The model used for generating images.
  ImageModels model;

  /// The quality of the generated images.
  ImageQuality quality;

  /// The size of the generated images.
  ImageSize size;

  /// The style applied to the generated images.
  ImageStyle style;

  /// Constructs an instance of [AbstractDalleModel].
  ///
  /// Initializes [model], [quality], [size], and [style] with the provided values.
  AbstractDalleModel(
    this.model,
    this.quality,
    this.size,
    this.style,
  );

  /// Returns a string representation of the instance.
  ///
  /// The returned string includes the properties of the model, quality,
  /// size, and style of the image.
  @override
  String toString() {
    return 'AbstractDalleModel(model: $model, quality: $quality, size: $size, style: $style)';
  }

  /// Compares this [AbstractDalleModel] instance with another for equality.
  ///
  /// Returns `true` if the [other] instance has the same [model], [quality],
  /// [size], and [style] as this instance. Otherwise, returns `false`.
  @override
  bool operator ==(covariant AbstractDalleModel other) {
    if (identical(this, other)) return true;

    return other.model == model &&
        other.quality == quality &&
        other.size == size &&
        other.style == style;
  }

  /// Generates a hash code for this [AbstractDalleModel] instance.
  ///
  /// The hash code is generated based on the [model], [quality], [size], and [style]
  /// properties. It's used to compare instances or insert them into collections like sets.
  @override
  int get hashCode {
    return model.hashCode ^ quality.hashCode ^ size.hashCode ^ style.hashCode;
  }
}
