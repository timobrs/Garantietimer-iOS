import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:garantietimer_ios/backend/user_service.dart';
import 'package:garantietimer_ios/frontend/login/forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showSignUpPage;
  const LoginPage({super.key, required this.showSignUpPage});

  @override
  State<LoginPage> createState() => _LoginPageCupertinoState();
}

class _LoginPageCupertinoState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userService = UserService();

  Future signIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showAlert('Bitte fülle alle Felder aus');
      return;
    }
    if (!_emailController.text.contains('@')) {
      _showAlert('Bitte gib eine gültige E-Mail-Adresse ein');
      return;
    }
    if (_passwordController.text.length < 6) {
      _showAlert('Das Passwort muss mindestens 6 Zeichen lang sein');
      return;
    }
    try {
      await _userService.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Ein Fehler ist aufgetreten.';
      if (e.code == 'user-not-found') {
        errorMessage = 'Benutzer nicht gefunden.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Falsches Passwort.';
      }
      _showAlert(errorMessage);
    }
  }

  void _showAlert(String message) {
    showCupertinoDialog(
      context: context,
      builder:
          (context) => CupertinoAlertDialog(
            title: Text(message),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: SizedBox(
                  width: 76,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/logo/Garantietimer-G.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text(
                'Willkommen zurück',
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0A2463),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Schön, dich wiederzusehen.',
                textAlign: TextAlign.center,
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: CupertinoColors.secondaryLabel,
                ),
              ),

              const SizedBox(height: 30),

              // E-Mail Adresse Textfeld
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
              const SizedBox(height: 15),

              // Passwort Textfeld
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: CupertinoTextField(
                  controller: _passwordController,
                  placeholder: 'Passwort',
                  obscureText: true,
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
                  prefix: const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12.0, 0, 0, 0),
                    child: Icon(CupertinoIcons.lock_fill),
                  ),
                ),
              ),

              // Passwort vergessen Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerRight,
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) {
                          return ForgotPasswordPage(
                            showLoginPage: () {
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Passwort vergessen?',
                    style: TextStyle(
                      color: CupertinoColors.link,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              // Einloggen Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CupertinoButton.filled(
                      onPressed: signIn,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Anmelden',
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
              const SizedBox(height: 30),

              // Registrieren Hinweis
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Noch keinen Account?',
                    style: TextStyle(
                      color: CupertinoColors.secondaryLabel,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Text(
                      'Jetzt registrieren',
                      style: TextStyle(
                        color: Color(0xFF0A2463),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    onPressed: () {
                      widget.showSignUpPage();
                    },
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
