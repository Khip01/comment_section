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
            return LoginPage();
          },
        ),
        GoRoute(
            path: "reqister",
            name: "register_page",
            builder: (context, state) {
              return RegisterPage();
            })
      ],
    ),
    GoRoute(
      path: "/",
      name: "comment_page",
      builder: (context, state) {
        return CommentPage();
      },
    ),
  ], initialLocation: "/welcome", debugLogDiagnostics: true, routerNeglect: true);

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      routerDelegate: _router.routerDelegate,
      routerConfig: _router,
    );
  }
}
