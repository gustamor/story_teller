import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/ui/core/providers/current_tale_id_provider.dart';
import 'package:story_teller/src/ui/core/providers/font_scale_provider.dart';
import 'package:story_teller/src/ui/screen/tale_generator/tale_from_history.dart';



class CardTile extends ConsumerStatefulWidget {
  const CardTile(
      {super.key,
      required this.title,
      required this.storyBody,
      this.author,
      required this.uuid,
      this.imageUrl});

  final String title;
  final String uuid;
  final String storyBody;
  final String? imageUrl;
  final String? author;
    @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardTileState();
}

class _CardTileState extends ConsumerState<CardTile> {
  
  buildImg(Color color, double height, BoxFit fit) {
    return InkWell(
      onTap: () {
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
    var fontScale = ref.watch(fontScaleNotifierProvider);
    ref.read(fontScaleNotifierProvider.notifier).loadFontScale();

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
              scrollOnCollapse: true,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 50.h,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: historyTitleText(
                        widget.title,
                        fontScale: fontScale,
                      ),
                    ),
                  ),
                ),
                collapsed: const SizedBox(),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    (widget.imageUrl != null)
                        ? buildImg(Colors.black, 256, BoxFit.cover)
                        : const SizedBox(),
                    Gap(16.h),
                    for (var _ in Iterable.generate(1))
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: historyBodyText(widget.storyBody, fontScale: fontScale),
                      ),
                    Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: storyAuthorText(
                        widget.author!,
                        fontScale: fontScale,
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
