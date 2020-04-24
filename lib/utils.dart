import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ozen_app/api/track.dart';
import 'package:ozen_app/components/chat/chat_current_track_widget.dart';
import 'package:ozen_app/components/sliding_panel.dart';
import 'package:ozen_app/pages/chat_panel.dart';
import 'package:ozen_app/pages/share_panel.dart';
import 'package:ozen_app/extensions.dart';
import 'dart:math';

void pushAnimatedRoute({
  BuildContext context,
  Duration duration = const Duration(milliseconds: 1250),
  Widget Function(BuildContext) builder,
}) {
  Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: duration,
      fullscreenDialog: true,
      opaque: false,
      pageBuilder: (context, animation, animation2) {
        final _animation =
            CurvedAnimation(curve: Curves.easeInOut, parent: animation);
        return CircularRevealAnimation(
          animation: _animation,
          centerAlignment: Alignment.center,
          child: builder(context),
        );
      },
    ),
  );
}

void pushAndReplaceAnimatedRoute({
  BuildContext context,
  Duration duration = const Duration(milliseconds: 1250),
  Widget Function(BuildContext) builder,
}) {
  Navigator.of(context).pushReplacement(
    PageRouteBuilder(
      transitionDuration: duration,
      pageBuilder: (context, animation, animation2) {
        final _animation =
            CurvedAnimation(curve: Curves.easeInOut, parent: animation);
        return CircularRevealAnimation(
          animation: _animation,
          centerAlignment: Alignment.center,
          child: builder(context),
        );
      },
    ),
  );
}

void showCustomSharePageModalSheet({BuildContext context, Track track}) {
  showCustomModalBottomSheet(
    context: context,
    barrierColor: Colors.black.withOpacity(0.6),
    builder: (_, scrollController) => SharePanel(),
    containerWidget: (_, animation, child) => Material(
      type: MaterialType.transparency,
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Transform.translate(
                  offset: Offset(0.0, 50.0 * (1.0 - animation.value)),
                  child: Opacity(
                    opacity: (animation.value * animation.value),
                    child: SharePanelSong(
                      track: track,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12.0),
                ),
              ),
              child: SlidingPanel(
                expandHeight: false,
                title: 'Добавить в',
                child: child,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void showCustomChatPageModalSheet({BuildContext context}) {
  showCustomModalBottomSheet(
    context: context,
    barrierColor: Colors.black.withOpacity(0.6),
    builder: (_, scrollController) => ChatPanel(
      scrollController: scrollController,
    ),
    containerWidget: (_, animation, child) => Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: [
            Spacer(),
            Opacity(
              opacity: (animation.value * animation.value),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: ChatCurrentTrackWidget(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12.0),
                ),
              ),
              child: SlidingPanel(
                expandHeight: true,
                title: 'Чат',
                maxHeight: 0.5,
                child: child,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            ),
          ],
        ),
      ),
    ),
  );
}

void showCustomBottomSheet({
  BuildContext context,
  Widget Function(BuildContext, ScrollController) builder,
}) {
  showMaterialModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12.0),
      ),
    ),
    builder: builder,
  );
}
