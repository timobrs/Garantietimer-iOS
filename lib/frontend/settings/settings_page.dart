import 'package:flutter/cupertino.dart';
import 'package:garantietimer_ios/backend/user_service.dart';
import 'package:garantietimer_ios/frontend/settings/imprint_page.dart';
import 'package:garantietimer_ios/frontend/settings/privacy_police_page.dart';
import 'package:garantietimer_ios/frontend/settings/profile_page.dart';
import 'package:garantietimer_ios/frontend/settings/terms_of_use_page.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Einstellungen'),
      ),
      backgroundColor: const Color(0xFFF0F0F7),
      child: SafeArea(
        child: DefaultTextStyle(
          style: CupertinoTheme.of(
            context,
          ).textTheme.textStyle.copyWith(inherit: true),
          child: ListView(
            children: <Widget>[
              CupertinoListSection.insetGrouped(
                backgroundColor: const Color(0xFFF0F0F7),
                header: const Text('Konto'),
                children: [
                  CupertinoListTile(
                    title: Text(
                      _userService.currentUser?.displayName ?? 'Unbekannt',
                    ),
                    leading: const Icon(CupertinoIcons.person_fill),
                    trailing: const Icon(CupertinoIcons.chevron_forward),
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (BuildContext context) => ProfilePage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              CupertinoListSection.insetGrouped(
                backgroundColor: const Color(0xFFF0F0F7),
                header: const Text('Über uns'),
                children: [
                  CupertinoListTile(
                    title: const Text('Support'),
                    leading: const Icon(CupertinoIcons.bubble_left_fill),
                    trailing: const Icon(CupertinoIcons.chevron_forward),
                    onTap: () {
                      // Hier die Logik für den Support
                    },
                  ),
                  CupertinoListTile(
                    title: const Text('Instagram'),
                    leading: const Icon(
                      CupertinoIcons.camera_fill,
                    ), // Näher am Instagram-Logo
                    trailing: const Icon(CupertinoIcons.chevron_forward),
                    onTap: () {
                      // Hier die Logik für Instagram
                    },
                  ),
                  CupertinoListTile(
                    title: const Text('TikTok'),
                    leading: const Icon(
                      CupertinoIcons.music_note_2,
                    ), // Allgemeines Medien-Icon
                    trailing: const Icon(CupertinoIcons.chevron_forward),
                    onTap: () {
                      // Hier die Logik für TikTok
                    },
                  ),
                ],
              ),
              CupertinoListSection.insetGrouped(
                backgroundColor: const Color(0xFFF0F0F7),
                header: const Text('Rechtliches'),
                children: [
                  CupertinoListTile(
                    title: const Text('Impressum'),
                    leading: const Icon(
                      CupertinoIcons.info_circle_fill,
                    ), // Info-Symbol
                    trailing: const Icon(CupertinoIcons.chevron_forward),
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder:
                              (BuildContext context) => const ImprintPage(),
                        ),
                      );
                    },
                  ),
                  CupertinoListTile(
                    title: const Text('Datenschutzerklärung'),
                    leading: const Icon(
                      CupertinoIcons.lock_shield_fill,
                    ), // Symbol für Sicherheit/Datenschutz
                    trailing: const Icon(CupertinoIcons.chevron_forward),
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder:
                              (BuildContext context) =>
                                  const PrivacyPolicyPage(),
                        ),
                      );
                    },
                  ),
                  CupertinoListTile(
                    title: const Text('Nutzungsbedingungen'),
                    leading: const Icon(
                      CupertinoIcons.doc_text_fill,
                    ), // Symbol für Textdokument
                    trailing: const Icon(CupertinoIcons.chevron_forward),
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder:
                              (BuildContext context) =>
                                  const TermsOfServicePage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30.0), // Etwas weniger Abstand als vorher
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CupertinoButton.filled(
                  child: const Text('Logout'),
                  onPressed: () {
                    _userService.signOut();
                  },
                ),
              ),
              const SizedBox(height: 15.0), // Weniger Abstand zum Footer
              Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Zentriert den Text
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10.0,
                    ), // Weniger Abstand
                    child: const Text(
                      'Version 1.0.0',
                      style: TextStyle(color: CupertinoColors.systemGrey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
