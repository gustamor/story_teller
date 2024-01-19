// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/domain/abstract/widgets/abstract_ai_clickable_card.dart';
import 'package:story_teller/ui/themes/styles/text_styles.dart';
/// A customizable card component tailored for iOS platforms.
///
/// This widget provides a card view that can be customized with various properties such as size,
/// background color, an optional image, caption, description, and click behavior. It extends
/// [StatelessWidget] and implements [AbstractAiClickableCard] to maintain consistency across different
/// platform-specific card implementations.
class IosClickableCard extends StatelessWidget implements AbstractAiClickableCard {
  
  /// The height of the card. If null, the card will size itself to its parent's height.
  @override
  final double? height;
  
  /// The width of the card. If null, the card will size itself to its parent's width.
  @override
  final double? width;
  
  /// The image to display on the card, typically an asset path.
  @override
  final String? decorImage;
  
  /// Specifies how the image should be inscribed into the available space.
  @override
  final BoxFit? fit;
  
  /// The border radius of the card.
  @override
  final double? borderRadius;
  
  /// The caption text displayed on the card.
  @override
  final String? caption;
  
  /// The description text displayed beneath the caption.
  @override
  final String? description;
  
  /// The background color of the card. Defaults to the theme's card color if not specified.
  @override
  final Color? bgColor;
  
  /// The text style to use for text within the card.
  @override
  final TextStyle? textStyle;
  
  /// The callback function that is called when the card is tapped.
  @override
  final VoidCallback clickFunction;

  /// Creates an instance of [IosClickableCard].
  ///
  /// Receives a set of customizable attributes for adjusting the appearance and behavior of the card.
  const IosClickableCard({
    super.key,
    this.height,
    this.width,
    this.decorImage,
    this.fit,
    this.borderRadius,
    this.caption,
    this.description,
    this.bgColor,
    required this.clickFunction,
    this.textStyle,
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
        elevation: 4,
        color: bgColor ?? Theme.of(context).cardTheme.color,
        shadowColor: Theme.of(context).cardTheme.shadowColor,
        child: Padding(
          padding: EdgeInsets.only(left: 1.w, top: 0.0),
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
                        width: 120.w,
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(borderRadius ?? 32.r),
                            child: Image.asset(
                              decorImage!,
                              width: 120.w,
                              height: 120.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(12.h),
              // Container for the card's title text.
              Container(
                padding: EdgeInsets.only(left: 4.w),
                child: Text(caption!, style: IosStyle.cardCaption),
              ),
              Gap(6.h),
              // Container for the card's body text.
              Container(
                height: 48.h,
                width: 254.w,
                constraints: BoxConstraints(maxWidth: 252.w),
                padding: EdgeInsets.only(left: 4.w),
                child: Text(description!, style: IosStyle.cardDescription),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Implementations of the abstract properties from AbstractAiClickableCard.
  // These properties are specific to Android styling and are not used in the iOS card.
  // They throw UnimplementedError to indicate that they must be implemented if used.
  @override
  Color? get androidBackgroundColor => throw UnimplementedError();
  @override
  double? get androidElevation => throw UnimplementedError();
  @override
  Color? get androidShadowColor => throw UnimplementedError();
  @override
  Widget? get child => throw UnimplementedError();
  @override
  Clip? get clipBehavior => throw UnimplementedError();
  @override
  double? get elevation => throw UnimplementedError();
  @override
  Color? get iosBackgroundColor => throw UnimplementedError();
  @override
  EdgeInsetsGeometry? get margin => throw UnimplementedError();
  @override
  Color? get shadowColor => throw UnimplementedError();
  @override
  ShapeBorder? get shape => throw UnimplementedError();
  @override
  Color? get surfaceTintColor => throw UnimplementedError();
}
