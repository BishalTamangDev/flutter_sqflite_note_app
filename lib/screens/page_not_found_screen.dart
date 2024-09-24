import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sqlite/main.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.hourglass_empty,
              color: Colors.red,
            ),
            const SizedBox(height: 16.0),
            Text("Page Not Found!", style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                context.goNamed('home');
              },
              child: const Text("Goto Home"),
            ),
          ],
        ),
      ),
    );
  }
}
