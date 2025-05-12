import 'package:flutter/cupertino.dart';
import 'package:garantietimer_ios/backend/user_service.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignUpPage({super.key, required this.showLoginPage});

  @override
  State<SignUpPage> createState() => _SignUpPageCupertinoState();
}

class _SignUpPageCupertinoState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _userService = UserService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      showCupertinoDialog(
        context: context,
        builder:
            (context) => CupertinoAlertDialog(
              title: const Text('Passwörter stimmen nicht überein'),
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
      return;
    }
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      showCupertinoDialog(
        context: context,
        builder:
            (context) => CupertinoAlertDialog(
              title: const Text('Bitte fülle alle Felder aus'),
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
      return;
    }
    if (!_emailController.text.contains('@')) {
      showCupertinoDialog(
        context: context,
        builder:
            (context) => CupertinoAlertDialog(
              title: const Text('Bitte gib eine gültige E-Mail-Adresse ein'),
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
    if (_passwordController.text.length < 6) {
      showCupertinoDialog(
        context: context,
        builder:
            (context) => CupertinoAlertDialog(
              title: const Text(
                'Die Passwort muss mindestens 6 Zeichen lang sein',
              ),
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
      return;
    }
    if (_emailController.text.isEmpty) {
      showCupertinoDialog(
        context: context,
        builder:
            (context) => CupertinoAlertDialog(
              title: const Text('Bitte gib eine E-Mail Adresse ein'),
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
      return;
    }
    try {
      await _userService.signUpWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: _nameController.text.trim(),
      );
    } catch (e) {
      showCupertinoDialog(
        context: context,
        builder:
            (context) => CupertinoAlertDialog(
              title: const Text('Fehler bei der Registrierung'),
              content: Text(e.toString()),
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
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Herzlich Willkommen',
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0A2463),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Verpasse keine Garantie mehr!',
                textAlign: TextAlign.center,
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: CupertinoColors.secondaryLabel,
                ),
              ),

              const SizedBox(height: 30),

              // Name Textfeld
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: CupertinoTextField(
                  controller: _nameController,
                  prefix: const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12.0, 0, 0, 0),
                    child: Icon(CupertinoIcons.person_fill),
                  ),
                  placeholder: 'Name',
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
              const SizedBox(height: 15),

              // Passwort wiederholen Textfeld
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: CupertinoTextField(
                  controller: _confirmPasswordController,
                  placeholder: 'Passwort wiederholen',
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
              const SizedBox(height: 30),

              // Registrieren Button
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
                      onPressed: signUp,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Registrieren',
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

              // Bereits einen Account? Button
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bereits einen Account?',
                    style: TextStyle(
                      color: CupertinoColors.secondaryLabel,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Text(
                      'Jetzt anmelden',
                      style: TextStyle(
                        color: Color(0xFF0A2463),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    onPressed: () {
                      widget.showLoginPage();
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
