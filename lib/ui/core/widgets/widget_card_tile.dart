import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/ui/core/providers/current_tale_id_provider.dart';
import 'package:story_teller/ui/core/providers/font_scale_provider.dart';
import 'package:story_teller/ui/screen/tale_generator/tale_from_history.dart';

/// A widget that displays a story card with expandable content.
///
/// The widget provides a summarized view of a story and allows the user to expand the card to see more details.
/// It displays the story's title, body, image, and author. The card can be tapped to navigate to the full story screen.
class CardTile extends ConsumerStatefulWidget {
  /// Constructs a [CardTile] with the given properties.
  ///
  /// Initializes the story card with title, body, author, and an optional image.
  const CardTile({
    super.key,
    required this.title,
    required this.storyBody,
    this.author,
    required this.uuid,
    this.imageUrl,
  });

  /// The title of the story.
  final String title;

  /// A unique identifier for the story.
  final String uuid;

  /// The main body content of the story.
  final String storyBody;

  /// URL of the image associated with the story.
  final String? imageUrl;

  /// The author of the story.
  final String? author;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardTileState();
}

class _CardTileState extends ConsumerState<CardTile> {
  /// Builds an image widget for the story card.
  ///
  /// If an image URL is provided, it displays the image. Otherwise, it displays an empty container.
  buildImg(Color color, double height, BoxFit fit) {
    return InkWell(
      onTap: () {
        // Updates the current tale to show and navigates to the TaleFromHistoryScreen.
        ref.watch(taleToShowProvider.notifier).update((state) => state = widget.uuid);
        Navigator.pushNamed(context, TaleFromHistoryScreen.route);
      },
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
          ),
          child: (widget.imageUrl != null)
              ? Image.network(
                  widget.imageUrl!,
                  fit: fit,
                )
              : const SizedBox(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Retrieves the current font scaling factor from the app's settings.
    var fontScale = ref.watch(fontScaleNotifierProvider);
    ref.read(fontScaleNotifierProvider.notifier).loadFontScale();

    // The main widget structure using ExpandableNotifier and ExpandablePanel for an expandable card experience.
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              // Placeholder container for additional content if needed.
              SizedBox(
                height: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.rectangle,
                  ),
                ),
              ),
              // ExpandablePanel widget that manages the expanded and collapsed views of the card.
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: true,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  // Header of the expandable card.
                  header: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 50.h,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: historyTitleText(widget.title, fontScale: fontScale),
                      ),
                    ),
                  ),
                  // Collapsed view (initial state) of the card.
                  collapsed: const SizedBox(),
                  // Expanded view (after tap) of the card.
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Displays the story image or an empty container if no image is available.
                      (widget.imageUrl != null) ? buildImg(Colors.black, 256, BoxFit.cover) : const SizedBox(),
                      Gap(16.h),
                      // Displays the story body text.
                      for (var _ in Iterable.generate(1))
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: historyBodyText(widget.storyBody, fontScale: fontScale),
                        ),
                      // Displays the author text.
                      Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: storyAuthorText(widget.author!, fontScale: fontScale),
                      ),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
