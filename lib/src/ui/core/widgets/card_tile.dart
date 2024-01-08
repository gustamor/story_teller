
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/ui/core/providers/font_scale_provider.dart';

class CardTile extends ConsumerWidget {
  const CardTile(
      {super.key,
      required this.title,
      required this.storyBody,
      this.author,
       this.imageUrl});

  final String title;
  final String storyBody;
  final String? imageUrl;
  final String? author;

  buildImg(Color color, double height, BoxFit fit) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.rectangle,
        ),
        child: (imageUrl != null) ? Image.network(
          imageUrl!,
          fit: fit,
        ) :const SizedBox(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                  padding: const EdgeInsets.all(10),
                  child: historyTitleText(
                    title,
                   fontScale: ref.read(
                          fontScaleNotifierProvider,
                        ),
                  ),
                ),
                collapsed: const SizedBox(),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   (imageUrl != null) ? buildImg(Colors.black, 256, BoxFit.contain):const SizedBox(),
                    Gap(16.h),
                    for (var _ in Iterable.generate(1))
                      Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: historyBodyText(
                            storyBody,
                           fontScale: ref.read(
                          fontScaleNotifierProvider,
                        ),
                          )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: storyAuthorText(
                        author!,
                        fontScale: ref.read(
                          fontScaleNotifierProvider,
                        ),
                      ),
                    ),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
    ));
  }
}