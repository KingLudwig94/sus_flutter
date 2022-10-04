import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'infoView.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      path: 'assets/translations/',
      supportedLocales: [Locale('de'), Locale('en')],
      fallbackLocale: Locale('en'),
      useOnlyLangCode: true,
      useFallbackTranslations: true,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      title: 'SUS questionnaire',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SUS Questionnaire'),
        actions: [
          PopupMenuButton(
            icon: Text(context.locale.toLanguageTag().toUpperCase()),
            onSelected: (value) => context.setLocale(value as Locale),
            itemBuilder: (context) => context.supportedLocales
                .map((e) => PopupMenuItem<Locale>(
                    value: e, child: Text(e.toString().toUpperCase())))
                .toList(),
          )
        ],
      ),
      body: Center(
        child: Container(
            constraints:
                BoxConstraints(minWidth: MediaQuery.of(context).size.width / 2, maxWidth: MediaQuery.of(context).size.width-10),
            child: InfoView()),
      ),
    );
  }
}
