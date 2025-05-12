import 'package:flutter/cupertino.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: CupertinoScrollbar(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Datenschutzerklärung',
                  style: CupertinoTheme.of(context).textTheme.navTitleTextStyle
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                const SizedBox(height: 20.0),
                const CupertinoTextSection(
                  title:
                      'Der Schutz Ihrer persönlichen Daten ist uns wichtig. In dieser Datenschutzerklärung informieren wir Sie darüber, welche personenbezogenen Daten wir im Zusammenhang mit Ihrer Nutzung der mobilen Anwendung [Dein App-Name] (im Folgenden als "App" bezeichnet) erheben, verarbeiten und nutzen.',
                ),
                const SizedBox(height: 20.0),
                const CupertinoTextSection(
                  title: '1. Verantwortliche Stelle',
                  content: '''
[Dein Name oder der Name deiner Organisation/des Verantwortlichen]
[Deine Straße und Hausnummer]
[Deine Postleitzahl und dein Ort]
[Deine E-Mail-Adresse]
                  ''',
                ),
                const SizedBox(height: 15.0),
                const CupertinoTextSection(
                  title: '2. Erhebung und Verarbeitung personenbezogener Daten',
                  content:
                      'Wir erheben und verarbeiten personenbezogene Daten nur, soweit dies zur Bereitstellung und Optimierung der App erforderlich ist oder wenn Sie uns Ihre Einwilligung dazu erteilt haben.',
                ),
                const SizedBox(height: 15.0),
                const CupertinoTextSection(
                  title: '3. Arten der erhobenen Daten',
                  content: '''
- [Beispiel: Geräteinformationen (z.B. Gerätetyp, Betriebssystem)]
- [Beispiel: Nutzungsdaten (z.B. wie lange Sie die App nutzen, welche Funktionen Sie verwenden)]
- [Beispiel: Standortdaten (nur mit Ihrer ausdrücklichen Zustimmung)]
                  ''',
                ),
                const SizedBox(height: 15.0),
                const CupertinoTextSection(
                  title: '4. Zweck der Datenverarbeitung',
                  content: '''
- [Beispiel: Bereitstellung der Funktionen der App]
- [Beispiel: Verbesserung der App und Entwicklung neuer Funktionen]
- [Beispiel: Personalisierung der Nutzererfahrung (nur mit Ihrer Zustimmung)]
                  ''',
                ),
                const SizedBox(height: 20.0),
                const CupertinoTextSection(
                  title: '5. Weitergabe von Daten an Dritte',
                  content:
                      'Wir geben Ihre personenbezogenen Daten grundsätzlich nicht an Dritte weiter, es sei denn, dies ist zur Erfüllung unserer vertraglichen Pflichten erforderlich, gesetzlich vorgeschrieben oder Sie haben Ihre ausdrückliche Einwilligung dazu erteilt.',
                ),
                const SizedBox(height: 20.0),
                const CupertinoTextSection(
                  title: '6. Ihre Rechte',
                  content:
                      'Sie haben das Recht auf Auskunft, Berichtigung, Löschung, Einschränkung der Verarbeitung und Widerspruch gegen die Verarbeitung Ihrer personenbezogenen Daten.',
                ),
                const SizedBox(height: 30.0),
                Text(
                  'Letzte Aktualisierung: [Datum der letzten Aktualisierung]',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: CupertinoColors.secondaryLabel,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CupertinoTextSection extends StatelessWidget {
  final String title;
  final String? content;

  const CupertinoTextSection({required this.title, this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        if (content != null) ...[
          const SizedBox(height: 8.0),
          Text(content!, style: const TextStyle(fontSize: 16.0)),
        ],
      ],
    );
  }
}
