import 'package:flutter/cupertino.dart';
import 'package:garantietimer_ios/backend/user_service.dart';
import 'package:garantietimer_ios/frontend/devices/add_device_page.dart';
import 'package:garantietimer_ios/frontend/devices/manage_devices_page.dart';
import 'package:garantietimer_ios/frontend/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_stack_3d_up),
            label: 'Verwalten',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Einstellungen',
          ),
        ],
        activeColor: Color(0xFF0A2463),
        inactiveColor: CupertinoColors.systemGrey,
        backgroundColor: const Color(0xFFFAFAFA),
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder:
                  (context) => CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar(
                      trailing: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Icon(CupertinoIcons.add),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const AddDevicePage(),
                            ),
                          );
                        },
                      ),
                    ),
                    child: SafeArea(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          Text(
                            'Hi ${_userService.currentUser?.displayName ?? 'User'}',
                            style: CupertinoTheme.of(
                              context,
                            ).textTheme.navLargeTitleTextStyle.copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              inherit: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            );
          case 1:
            return CupertinoTabView(
              builder: (context) => const ManageDevicesPage(),
            );
          case 2:
            return CupertinoTabView(builder: (context) => SettingsPage());
          default:
            return CupertinoTabView(
              builder:
                  (context) => const Center(child: Text('Unbekannter Tab')),
            );
        }
      },
    );
  }
}
