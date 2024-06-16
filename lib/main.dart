import 'package:chessapp/pages/auth/auth_page.dart';
import 'package:chessapp/pages/auth/splash.dart';
import 'package:chessapp/pages/catalog/closed.dart';
import 'package:chessapp/pages/catalog/gambits.dart';
import 'package:chessapp/pages/catalog/halfopen.dart';
import 'package:chessapp/pages/catalog/open.dart';
import 'package:chessapp/pages/home.dart';
import 'package:chessapp/pages/profile.dart';
import 'package:chessapp/pages/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Jost'),
      debugShowCheckedModeBanner: false,
      home: const Splash(),
      routes: {
        '/open': (context) => const Open(),
        '/closed': (context) => const Closed(),
        '/halfopen': (context) => const Halfopen(),
        '/gambit': (context) => const Gambits(),
        '/home': (context) => const Home(),
        '/settings': (context) => const Settings(),
        '/profile': (context) => Profile(),
        '/login': (context) => const AuthPage(),
      },
    );
  }
}
