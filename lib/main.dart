import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:agenda/screens/index_screen.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyD_LlkH98Sr1ltgl10-glE-Jrq7yN-dcI0",
          projectId: "agenda-852fb",
          messagingSenderId: "96781833744",
          storageBucket: "agenda-852fb.appspot.com",
          appId: "1:96781833744:web:75415184475c6fcc3e9c95"));

  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('es', ''),
      ],
      locale: Locale('es'),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Indexscreen(),
    );
  }
}
