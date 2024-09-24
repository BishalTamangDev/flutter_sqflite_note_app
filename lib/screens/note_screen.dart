import 'package:flutter/material.dart';
import 'package:note_sqlite/common/widgets/text_field_widget.dart';

import '../common/widgets/elevated_button_widget.dart';
import '../data/local/local_note_db.dart';
import '../data/models/note_model.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({
    super.key,
    this.task = "add",
    required this.note,
    required this.callBack,
  });

  final NoteModel note;
  final String task;
  final VoidCallback callBack;

  @override
  State<StatefulWidget> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  // controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // variables
  bool error = false;
  String errorMessage = "An error occurred.";

  @override
  void initState() {
    titleController.text = widget.note.title;
    descriptionController.text = widget.note.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == "add" ? "Add New Note" : "Edit Note"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),

              // title
              TextFieldWidget(
                controller: titleController,
                label: "Title",
              ),
              const SizedBox(height: 16.0),

              // description
              TextFieldWidget(
                controller: descriptionController,
                label: "Description",
              ),

              const SizedBox(height: 16.0),

              //   button :: add || update
              SizedBox(
                width: double.infinity,
                height: 48.0,
                child: ElevatedButtonWidget(
                  buttonTitle: widget.task == "add" ? "Add Now" : "Update Now",
                  callBack: () async {
                    NoteDb noteDb = NoteDb.getInstance();

                    // title
                    String noteTitle = titleController.text;

                    // description
                    String noteDescription = descriptionController.text ?? "";

                    if (noteTitle.isNotEmpty) {
                      //   get date & time
                      DateTime noteDateTime = DateTime.now();

                      //   add || edit
                      if (widget.task == "add") {
                        bool status = await noteDb.addNote(noteTitle,
                            noteDescription, noteDateTime.toString());

                        if (status) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Center(
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 40.0,
                                        backgroundColor: Colors.grey.shade100,
                                        foregroundColor: Colors.green,
                                        child: const Icon(
                                          Icons.check,
                                          size: 32.0,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      const Text("Note added successfully!"),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                          widget.callBack();

                          titleController.clear();
                          descriptionController.clear();
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Center(
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 40.0,
                                        backgroundColor: Colors.grey.shade100,
                                        foregroundColor: Colors.red,
                                        child: const Icon(
                                          Icons.cancel,
                                          size: 32.0,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      const Text("Note couldn't be added!"),
                                      const SizedBox(height: 10.0),
                                      ElevatedButtonWidget(callBack: () {
                                        Navigator.pop(context);
                                      }),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      } else {
                        bool status = await noteDb.updateNote(
                          widget.note.id,
                          noteTitle,
                          noteDescription,
                          noteDateTime.toString(),
                        );

                        if (status) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Center(
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 40.0,
                                        backgroundColor: Colors.grey.shade100,
                                        foregroundColor: Colors.green,
                                        child: const Icon(
                                          Icons.check,
                                          size: 32.0,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      const Text("Note updated successfully!"),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                          widget.callBack();
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Center(
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 40.0,
                                        backgroundColor: Colors.grey.shade100,
                                        foregroundColor: Colors.red,
                                        child: const Icon(
                                          Icons.cancel,
                                          size: 32.0,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      const Text("Note couldn't be updated!"),
                                      const SizedBox(height: 10.0),
                                      ElevatedButtonWidget(callBack: () {
                                        Navigator.pop(context);
                                      }),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }
                    } else {
                      error = true;
                      errorMessage = "Please enter the title";
                      setState(() {});
                    }
                  },
                ),
              ),

              const SizedBox(height: 16.0),

              // error message
              if (error)
                Text(
                  errorMessage,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.red,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
