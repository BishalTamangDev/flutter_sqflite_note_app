// Custom class to hold multiple parameters
import 'dart:ui';

import 'note_model.dart';

class MyParams {
  final VoidCallback callback;
  final NoteModel note;

  MyParams({required this.callback, required this.note});
}
