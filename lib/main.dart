import 'package:comment_section/pages/comment_page.dart';
import 'package:comment_section/pages/landing_page.dart';
import 'package:comment_section/pages/login_page.dart';
import 'package:comment_section/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Routing
  // / Landing Page / Login
  //              / Register

  // / Comment Section (Logout to go to Landing Page)

  // Go Router
  final GoRouter _router = GoRouter(routes: [
    GoRoute(
      path: "/welcome",
      name: "landing_page",
      builder: (context, state) {
        return LandingPage();
      },
      routes: [
        GoRoute(
          path: "login",
          name: "login_page",
          builder: (context, state) {
            return const LoginPage();
          },
        ),
        GoRoute(
            path: "register",
            name: "register_page",
            builder: (context, state) {
              return const RegisterPage();
            })
      ],
    ),
    GoRoute(
      path: "/",
      name: "comment_page",
      builder: (context, state) {
        return const CommentPage();
      },
    ),
  ], initialLocation: "/welcome", debugLogDiagnostics: true, routerNeglect: true);

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        // colorSchemeSeed: Color.fromARGB(255, 241, 241, 241),
        colorScheme: ColorScheme(brightness: Brightness.light, primary: Colors.black, onPrimary: Colors.blue, secondary: Colors.white70, onSecondary: Colors.white54, error: Colors.red, onError: Colors.redAccent, background: Colors.white, onBackground: Colors.black, surface: Colors.white, onSurface: Colors.black),
      ),
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      routerDelegate: _router.routerDelegate,
      debugShowCheckedModeBanner: false, // Remove Debug banner when debugging
    );
  }
}
