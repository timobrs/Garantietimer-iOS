import 'package:flutter/cupertino.dart';

class ImprintPage extends StatelessWidget {
  const ImprintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Impressum',
                style: CupertinoTheme.of(context).textTheme.navTitleTextStyle
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'Angaben gemäß § 5 Telemediengesetz (TMG):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text('[Dein Name oder der Name deiner Organisation]'),
              Text('[Deine Straße und Hausnummer]'),
              Text('[Deine Postleitzahl und dein Ort]'),
              Text('[Deine E-Mail-Adresse]'),
              Text('[Deine Telefonnummer (optional)]'),
              SizedBox(height: 20.0),
              Text(
                'Vertretungsberechtigte/r (falls zutreffend):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text('[Name des/der Vertretungsberechtigten]'),
              SizedBox(height: 20.0),
              Text(
                'Umsatzsteuer-Identifikationsnummer (falls vorhanden):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text('[Deine USt-ID]'),
              SizedBox(height: 20.0),
              Text(
                'Verantwortlich für den Inhalt nach § 55 Abs. 2 Rundfunkstaatsvertrag (RStV):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text('[Dein Name oder der Name der verantwortlichen Person]'),
              Text('[Deine Adresse (falls abweichend)]'),
              SizedBox(height: 20.0),
              Text(
                'Haftungsausschluss:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'Der Anbieter übernimmt keine Haftung für die Inhalte externer Links. Für den Inhalt der verlinkten Seiten sind ausschließlich deren Betreiber verantwortlich.',
              ),
              SizedBox(height: 20.0),
              Text(
                'Urheberrecht:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'Die durch die Seitenbetreiber erstellten Inhalte und Werke auf diesen Seiten unterliegen dem deutschen Urheberrecht. Die Vervielfältigung, Bearbeitung, Verbreitung und jede Art der Verwertung außerhalb der Grenzen des Urheberrechtes bedürfen der schriftlichen Zustimmung des jeweiligen Autors bzw. Erstellers.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
