import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/domain/abstract/widgets/abstract_ai_clickable_card.dart';
/// A customizable card component tailored for Android platforms, adhering to Material Design guidelines.
///
/// This widget provides a card view that can be customized with various properties such as size,
/// background color, an optional image, caption, description, and click behavior. It extends
/// [StatelessWidget] and implements [AbstractAiClickableCard] to maintain consistency across different
/// platform-specific card implementations.
class AndroidAiClickableCard extends StatelessWidget implements AbstractAiClickableCard {
  
  /// The height of the card. If null, the card will size itself to its parent's height.
  @override
  final double? height;
  
  /// The width of the card. If null, the card will size itself to its parent's width.
  @override
  final double? width;
  
  /// The background color of the card. Defaults to the theme's card color if not specified.
  @override
  final Color? bgColor;
  
  /// The Android-specific background color. Overrides [bgColor] when set.
  @override
  final Color? androidBackgroundColor;
  
  /// The image to display on the card, typically an asset path.
  @override
  final String? decorImage;
  
  /// The caption text displayed on the card.
  @override
  final String? caption;
  
  /// The description text displayed beneath the caption.
  @override
  final String? description;
  
  /// The callback function that is called when the card is tapped.
  @override
  final VoidCallback clickFunction;
  
  /// Specifies how the image should be inscribed into the available space.
  @override
  final BoxFit? fit;
  
  /// The border radius of the card.
  @override
  final double? borderRadius;
  
  /// The elevation shadow depth specific to Android styling.
  @override
  final double? androidElevation;
  
  /// The color of the shadow cast by the card specific to Android styling.
  @override
  final Color? androidShadowColor;
  
  /// An optional widget to display within the card, typically used for content that isn't just text.
  @override
  final Widget? child;
  
  /// The behavior when a clip is applied to the card.
  @override
  final Clip? clipBehavior;
  
  /// The z-coordinate at which to place the card. This controls the size of the shadow below the card.
  @override
  final double? elevation;
  
  /// Empty space to surround the card.
  @override
  final EdgeInsetsGeometry? margin;
  
  /// The color of the shadow cast by the card.
  @override
  final Color? shadowColor;
  
  /// The shape of the card's material.
  @override
  final ShapeBorder? shape;
  
  /// The color of the material's surface tint.
  @override
  final Color? surfaceTintColor;
  
  /// The text style to use for text within the card.
  @override
  final TextStyle? textStyle;

  /// Creates an instance of [AndroidAiClickableCard].
  ///
  /// Receives a set of customizable attributes for adjusting the appearance and behavior of the card.
  const AndroidAiClickableCard({
    super.key,
    this.height,
    this.width,
    this.bgColor,
    this.androidBackgroundColor,
    this.caption,
    this.decorImage = "",
    this.fit,
    this.borderRadius = 16.0,
    this.description,
    required this.clickFunction,
    this.androidElevation,
    this.androidShadowColor,
    this.child,
    this.shape,
    this.shadowColor,
    this.surfaceTintColor,
    this.textStyle,
    this.clipBehavior,
    this.elevation,
    this.margin,
  });

  /// Builds the visual structure of the card widget.
  ///
  /// It composes various UI elements such as an image, a caption, and a description, applying
  /// the specified styles and behaviors.
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: clickFunction,
      child: Card(
        elevation: elevation ?? 4,
        color: androidBackgroundColor ?? bgColor ?? Theme.of(context).cardTheme.color,
        shadowColor: androidShadowColor ?? shadowColor ?? Theme.of(context).cardTheme.shadowColor,
        margin: margin,
        shape: shape,
        clipBehavior: clipBehavior ?? Clip.none,
        child: Padding(
          padding: EdgeInsets.only(left: 1.0.w, top: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height,
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: height,
                        width: 112.w, // Width of the image container.
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
                            child: Image.asset(
                              decorImage!, // The image to display.
                              width: 100.w,
                              height: 100.h,
                              fit: fit ?? BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(2.h), // Vertical space between image and title.
                        Container(
                          padding: EdgeInsets.only(left: 4.w),
                          child: cardTitleText(caption!, fontScale: 0.5), // Card's title text.
                        ),
                        Gap(6.h), // Vertical space between title and body.
                        Container(
                          height: 48.h,
                          width: double.infinity,
                          constraints: BoxConstraints(maxWidth: 120.w),
                          padding: EdgeInsets.only(left: 4.w),
                          child: cardBodyText(description!, fontScale: 0.5), // Card's body text.
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// No use. A placeholder for iOS-specific background color. Throws [UnimplementedError] as it's not implemented.
  @override
  Color? get iosBackgroundColor => throw UnimplementedError();
}
