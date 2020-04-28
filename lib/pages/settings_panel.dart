import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ozen_app/pages/sign_in_page.dart';
import 'package:ozen_app/state/binding.dart';
import 'package:ozen_app/state/state.dart';
import 'package:ozen_app/extensions.dart';
import 'package:ozen_app/utils.dart';

class SettingsPanel extends StatefulWidget {
  final ScrollController scrollController;

  const SettingsPanel({Key key, this.scrollController}) : super(key: key);

  @override
  _SettingsPanelState createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel> {
  @override
  Widget build(BuildContext context) {
    final state = ModelBinding.of<AppState>(context);

    return SingleChildScrollView(
      controller: widget.scrollController,
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        bottom: 24.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ozen-stream-beta-rc-1',
            style: context.textTheme.caption,
          ),
          SizedBox(height: 24.0),
          if (state.currentUser != null) ...[
            Text(
              'Вы вошли как',
              style: TextStyle(
                color: context.textTheme.caption.color,
              ),
            ),
            Row(
              children: [
                Text(
                  '${state.currentUser.username}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
                Spacer(),
                RaisedButton(
                  child: Text('Выйти'),
                  color: Colors.red,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    ModelBinding.update<AppState>(
                      context,
                      AppState(
                        currentTrack: state.currentTrack,
                        history: state.history,
                        isLoading: state.isLoading,
                        isPlaying: state.isPlaying,
                        currentUser: null,
                        messages: state.messages,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
          if (state.currentUser == null) ...[
            Text(
              'Вы не вошли в систему',
              style: TextStyle(
                color: context.textTheme.caption.color,
              ),
            ),
            SizedBox(height: 12.0),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                child: Text('Войти'),
                color: context.theme.primaryColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                onPressed: () {
                  Navigator.of(context).popUntil((p) => p.isFirst);
                  pushAndReplaceAnimatedRoute(
                    context: context,
                    builder: (_) => SignInPage(),
                  );
                },
              ),
            )
          ],
        ],
      ),
    );
  }
}
