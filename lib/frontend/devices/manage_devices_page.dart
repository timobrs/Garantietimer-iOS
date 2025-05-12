import 'package:flutter/cupertino.dart';

class ManageDevicesPage extends StatelessWidget {
  const ManageDevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Geräte verwalten'),
      ),
      child: SafeArea(
        child: Center(
          child: Text(
            'Geräte verwalten',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ),
      ),
    );
  }
}
