import 'package:flutter/cupertino.dart';
import 'package:garantietimer_ios/backend/user_service.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Profilseite',
                style:
                    CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CupertinoButton(
                  child: const Text('Account löschen'),
                  onPressed: () {
                    _userService.deleteAccount();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
