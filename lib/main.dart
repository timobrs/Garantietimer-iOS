import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:garantietimer_ios/frontend/login/login_check_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialisiere Firebase
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
    print("Firebase erfolgreich initialisiert!");
  } catch (e) {
    print("Fehler bei der Firebase-Initialisierung: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(
        primaryColor: Color(0xFF0A2463),
        scaffoldBackgroundColor: Color(0xFFF0F0F7),
        barBackgroundColor: CupertinoColors.white,
        textTheme: CupertinoTextThemeData(
          navTitleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0A2463),
          ),
          navLargeTitleTextStyle: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w700,
            color: Color(0xFF000000),
            inherit: true,
          ),
        ),
      ),
      home: LoginCheckPage(),
    );
  }
}
