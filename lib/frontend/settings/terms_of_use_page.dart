import 'package:flutter/cupertino.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: CupertinoScrollbar(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(20.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Text(
                      'Nutzungsbedingungen',
                      style: CupertinoTheme.of(
                        context,
                      ).textTheme.navTitleTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Bitte lesen Sie diese Nutzungsbedingungen sorgfältig durch, bevor Sie [Dein App-Name] nutzen. Durch die Nutzung unserer App erklären Sie sich mit diesen Bedingungen einverstanden.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      '1. Geltungsbereich',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Diese Nutzungsbedingungen regeln die Nutzung der von [Dein Unternehmen/Entwicklername] bereitgestellten mobilen Anwendung [Dein App-Name] (im Folgenden als "App" bezeichnet).',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      '2. Nutzerkonto',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Für bestimmte Funktionen der App ist möglicherweise die Erstellung eines Nutzerkontos erforderlich. Sie sind verantwortlich für die Geheimhaltung Ihrer Anmeldedaten und für alle Aktivitäten, die unter Ihrem Konto stattfinden.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      '3. Nutzung der App',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Sie dürfen die App nur in Übereinstimmung mit diesen Nutzungsbedingungen und allen geltenden Gesetzen und Vorschriften nutzen. Es ist Ihnen untersagt, die App für illegale oder unbefugte Zwecke zu verwenden.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      '4. Geistiges Eigentum',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Alle Rechte an der App und ihren Inhalten (einschließlich, aber nicht beschränkt auf Texte, Grafiken, Logos, Icons, Bilder, Audio- und Videoclips) sind Eigentum von [Dein Unternehmen/Entwicklername] oder seinen Lizenzgebern.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      '5. Haftungsausschluss',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Die App wird "wie besehen" und "wie verfügbar" ohne jegliche Gewährleistungen bereitgestellt.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      '6. Änderungen der Nutzungsbedingungen',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Wir behalten uns das Recht vor, diese Nutzungsbedingungen jederzeit zu ändern. Änderungen werden in der App oder durch andere geeignete Mittel bekannt gegeben. Die fortgesetzte Nutzung der App nach solchen Änderungen gilt als Ihre Zustimmung zu den geänderten Bedingungen.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 30.0),
                    Text(
                      'Letzte Aktualisierung: [Datum der letzten Aktualisierung]',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: CupertinoColors.secondaryLabel,
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
