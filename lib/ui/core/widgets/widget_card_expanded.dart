// ignore_for_file: prefer_const_constructors

// ignore: use_key_in_widget_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/ui/core/providers/current_tale_id_provider.dart';
import 'package:story_teller/ui/core/providers/font_scale_provider.dart';
import 'package:story_teller/ui/screen/tale_generator/tale_from_history.dart';

/// A widget that displays detailed information about a story in an expandable card format.
///
/// The widget provides a rich display of a story including title, body, image, author, and date. It allows users
/// to view a summarized version of the story and expand the card to see the full details.
class CardExpandedWidget extends ConsumerWidget {
  /// A unique identifier for the story.
  final String uuid;

  /// The title of the story.
  final String title;

  /// The main body content of the story.
  final String storyBody;

  /// URL of the image associated with the story.
  final String? imageUrl;

  /// The author of the story.
  final String? author;

  /// The publication date of the story.
  final String? date;

  /// Constructs a [CardExpandedWidget] with the given properties.
  ///
  /// The widget initializes with details about the story including title, body, author, date, and associated image.
  const CardExpandedWidget({
    super.key,
    required this.title,
    required this.storyBody,
    this.author,
    this.date,
    this.imageUrl,
    required this.uuid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retrieves the current font scaling factor from the app's settings.
    final fontScale = ref.watch(fontScaleNotifierProvider);

    // Builds an image widget for the story card.
    buildImg(Color color, double height, BoxFit fit) {
      return SizedBox(
        height: height,
        width: double.infinity,
        child: InkWell(
          onTap: () {
            // Updates the current tale to show and navigates to the TaleFromHistoryScreen.
            ref.watch(taleToShowProvider.notifier).update(
                  (state) => state = uuid,
                );

            Navigator.pushNamed(
              context,
              TaleFromHistoryScreen.route,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.rectangle,
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl ?? klibraryImage,
              fit: BoxFit.fill,
              placeholder: (context, url) => const CupertinoActivityIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      );
    }

    // Builds the collapsed state view for the top part of the card.
    buildCollapsed1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  historyTitleText(title, fontScale: fontScale),
                ],
              ),
            ),
          ]);
    }

    // Builds the collapsed state view for the middle part of the card.
    buildCollapsed2() {
      return buildImg(
        Theme.of(context).scaffoldBackgroundColor,
        128,
        BoxFit.cover,
      );
    }

    // Builds the collapsed state view for the bottom part of the card.
    buildCollapsed3() {
      return Container();
    }

    // Builds the expanded state view for the top part of the card.
    buildExpanded1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  historyTitleText(title, fontScale: fontScale),
                  Row(
                    children: [
                      historyAuthorText(author ?? "", fontScale: fontScale),
                      historyAuthorText(",  ", fontScale: fontScale),
                      historyAuthorText(date ?? "", fontScale: fontScale),
                    ],
                  )
                ],
              ),
            ),
          ]);
    }

    // Builds the expanded state view for the middle part of the card.
    buildExpanded2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: buildImg(
                  Theme.of(context).cardColor,
                  256,
                  BoxFit.contain,
                ),
              ),
            ],
          ),
        ],
      );
    }

    // Builds the expanded state view for the bottom part of the card.
    buildExpanded3() {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            historyBodyText(storyBody, fontScale: fontScale),
          ],
        ),
      );
    }

    // The main widget structure using ExpandableNotifier and ScrollOnExpand for an expandable card experience.
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 10,
        ),
        child: ScrollOnExpand(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expandable(
                  collapsed: buildCollapsed1(),
                  expanded: buildExpanded1(),
                ),
                Expandable(
                  collapsed: buildCollapsed2(),
                  expanded: buildExpanded2(),
                ),
                Expandable(
                  collapsed: buildCollapsed3(),
                  expanded: buildExpanded3(),
                ),
                const Divider(height: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Builder(
                      builder: (context) {
                        var controller = ExpandableController.of(context, required: true)!;
                        return TextButton(
                          child: Text(
                            controller.expanded ? tr("close_mays") : tr("open_mays"),
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.deepPurple),
                          ),
                          onPressed: () {
                            controller.toggle();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
