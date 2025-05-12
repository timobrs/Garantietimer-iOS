import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:garantietimer_ios/frontend/home/home_page.dart';
import 'package:garantietimer_ios/frontend/login/auth_page.dart';

class LoginCheckPage extends StatelessWidget {
  const LoginCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.hasData) {
            return HomePage();
          }
          return AuthPage();
        },
      ),
    );
  }
}
