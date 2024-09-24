import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/note_model.dart';
import '../../data/models/note_param.dart';
import 'elevated_button_widget.dart';

class NoteDetailWidget extends StatelessWidget {
  const NoteDetailWidget({
    super.key,
    required this.note,
    required this.callback,
  });

  final NoteModel note;

  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      // initialChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (
        BuildContext context,
        ScrollController scrollController,
      ) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          child: ListView(
            controller: scrollController,
            children: [
              // note title
              Container(
                color: Theme.of(context).canvasColor,
                child: Text(
                  note.title.isNotEmpty ? note.title : "No title",
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),

              const SizedBox(height: 16.0),

              // note description
              if (note.description.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Theme.of(context).canvasColor,
                      child: Text(
                        note.description,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),

              // note date time
              Text(
                note.dateTime,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.grey,
                    ),
              ),

              const SizedBox(height: 16.0),

              // actions :: edit
              Row(
                children: [
                  SizedBox(
                    height: 40.0,
                    child: ElevatedButtonWidget(
                      callBack: () {
                        context.pushNamed(
                          'note',
                          pathParameters: {'task': 'edit'},
                          extra: MyParams(
                            callback: callback,
                            note: note,
                          ),
                        );
                      },
                      buttonTitle: "Edit Note",
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
