import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:garantietimer_ios/backend/user_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const ForgotPasswordPage({super.key, required this.showLoginPage});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _userService = UserService();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await _userService.sendPasswordResetEmail(_emailController.text.trim());
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Passwort erfolgreich zurückgesetzt'),
            content: Text(
              'Eine E-Mail zum Zurücksetzen des Passworts wurde gesendet.',
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text('Fehler'),
              content: Text(e.message.toString()),
              actions: [
                CupertinoDialogAction(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Passwort zurücksetzen'),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: const Text(
                'Geb deine E-Mail-Adresse ein, um dein Passwort zurückzusetzen.',
              ),
            ),
            const SizedBox(height: 20),

            // Textfeld für E-Mail-Adresse
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: CupertinoTextField(
                controller: _emailController,
                prefix: const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 0, 0, 0),
                  child: Icon(CupertinoIcons.mail_solid),
                ),
                placeholder: 'E-Mail',
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: CupertinoColors.systemGrey3,
                    width: 1,
                  ),
                ),
                style: const TextStyle(color: CupertinoColors.black),
                placeholderStyle: const TextStyle(
                  color: CupertinoColors.placeholderText,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Passwort zurücksetzen Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CupertinoButton.filled(
                    onPressed: () {
                      passwordReset();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Passwort zurücksetzen',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: CupertinoColors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          CupertinoIcons.arrow_right,
                          color: CupertinoColors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
