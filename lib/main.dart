import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sqlite/data/models/note_model.dart';
import 'package:note_sqlite/screens/home_screen.dart';
import 'package:note_sqlite/screens/note_screen.dart';
import 'package:note_sqlite/screens/page_not_found_screen.dart';

import 'data/models/note_param.dart';

// router
GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/note/:task',
      name: 'note',
      builder: (context, state) {
        final MyParams params = state.extra as MyParams;
        final String task = state.pathParameters['task'] ?? "add";

        return NoteScreen(
          task: task,
          note: params.note,
          callBack: params.callback,
        );
      },
    ),
  ],
  errorBuilder: (context, state) => const PageNotFoundScreen(),
);

void main() {
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Note Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
    );
  }
}
