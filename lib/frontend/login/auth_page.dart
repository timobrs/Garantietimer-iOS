import 'package:flutter/cupertino.dart';
import 'package:garantietimer_ios/frontend/login/login_page.dart';
import 'package:garantietimer_ios/frontend/login/sign_up_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showSignUpPage: togglePages);
    } else {
      return SignUpPage(showLoginPage: togglePages);
    }
  }
}
