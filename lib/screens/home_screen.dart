import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sqlite/data/local/local_note_db.dart';
import 'package:note_sqlite/data/models/note_model.dart';

import '../common/widgets/note_detail_widget.dart';
import '../data/models/note_param.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NoteDb db = NoteDb.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: db.getAllNotes(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16.0),
                  Text("Loading the notes."),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "An error occurred.",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            );
          } else {
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.hourglass_empty),
                        SizedBox(height: 16.0),
                        Text(
                          "Your note list is empty!",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 5.0),
                        ListView.builder(
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            NoteModel note = NoteModel(
                              id: snapshot.data![index]['id'],
                              title: snapshot.data![index]['title'],
                              description: snapshot.data![index]['description'],
                              dateTime: snapshot.data![index]['date_time'],
                            );
                            return InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return NoteDetailWidget(
                                      note: note,
                                      callback: () {
                                        setState(() {});
                                      },
                                    );
                                  },
                                );
                              },
                              child: Card(
                                child: ListTile(
                                  title: Text(
                                    note.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5.0),
                                      Text(
                                        note.description,
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  trailing: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text("Delete note?"),
                                          content: const Text(
                                              "Are you sure you want to delete this note permanently?"),
                                          actions: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                              ),
                                              onPressed: () async {
                                                //   delete note
                                                log("Delete note: ${note.id}");
                                                bool status = await db
                                                    .deleteNote(note.id);
                                                if (status) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          "Note deleted successfully."),
                                                    ),
                                                  );
                                                  setState(() {});
                                                  Navigator.pop(context);
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          "Note couldn't be deleted."),
                                                    ),
                                                  );
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: const Text("Yes, Delete"),
                                            ),
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                "No, Keep It",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: const Icon(Icons.delete),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NoteModel note = NoteModel(
            id: 0,
            title: "",
            description: "",
            dateTime: DateTime.now().toString(),
          );
          //   add note :: navigate to add note screen
          context.pushNamed(
            'note',
            pathParameters: {'task': 'add'},
            extra: MyParams(
              callback: () {
                setState(() {});
              },
              note: note,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
