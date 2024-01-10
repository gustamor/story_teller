// ignore_for_file: prefer_const_constructors

// ignore: use_key_in_widget_constructors
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/ui/core/providers/current_tale_id_provider.dart';
import 'package:story_teller/src/ui/core/providers/font_scale_provider.dart';
import 'package:story_teller/src/ui/screen/tale_generator/tale_from_history.dart';

class CardExpanded extends ConsumerWidget {
  final String uuid;
  final String title;
  final String storyBody;
  final String? imageUrl;
  final String? author;
  final String? date;

  const CardExpanded({
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
    final fontScale = ref.read(
      fontScaleNotifierProvider,
    );

    buildImg(Color color, double height, BoxFit fit) {
      return SizedBox(
        height: height,
        width: double.infinity,
        child: InkWell(
          onTap: () {
            ref
                .watch(taleToShowProvider.notifier)
                .update((state) => state = uuid);

            Navigator.pushNamed(context, TaleFromHistoryScreen.route);
          },
          child: Container(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.rectangle,
            ),
            child: Image.network(
              imageUrl ?? "",
              fit: fit,
            ),
          ),
        ),
      );
    }

    buildCollapsed1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  historyTitleText(
                    title,
                    fontScale: fontScale,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildCollapsed2() {
      return buildImg(
          Theme.of(context).scaffoldBackgroundColor, 128, BoxFit.cover);
    }

    buildCollapsed3() {
      return Container();
    }

    buildExpanded1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  historyTitleText(
                    title,
                    fontScale: fontScale,
                  ),
                  Row(
                    children: [
                      historyAuthorText(
                        author ?? "",
                        fontScale: fontScale,
                      ),
                      historyAuthorText(
                        ", ",
                        fontScale: fontScale,
                      ),
                      historyAuthorText(
                        date ?? "",
                        fontScale: fontScale,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ]);
    }

    buildExpanded2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: buildImg(
                      Theme.of(context).cardColor, 256, BoxFit.contain)),
            ],
          ),
        ],
      );
    }

    buildExpanded3() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            historyBodyText(storyBody, fontScale: fontScale),
          ],
        ),
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
              const Divider(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Builder(
                    builder: (context) {
                      var controller =
                          ExpandableController.of(context, required: true)!;
                      return TextButton(
                        child: Text(
                          controller.expanded
                              ? tr("close_mays")
                              : tr("open_mays"),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.deepPurple),
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
    ));
  }
}
