import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Notes App',
home: NotesScreen(),
);
}
}

class NotesScreen extends StatefulWidget {
@override
_NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
List<String> notes = [];
List<bool> isNoteDone = [];

bool showCompletedNotes = false;

@override
Widget build(BuildContext context) {
List<String> filteredNotes = showCompletedNotes
? notes.where((note) => isNoteDone[notes.indexOf(note)]).toList()
: notes.where((note) => !isNoteDone[notes.indexOf(note)]).toList();

return Scaffold(
appBar: AppBar(
title: Text('Notes App'),
actions: <Widget>[
IconButton(
icon: Icon(showCompletedNotes ? Icons.check_box : Icons.check_box_outline_blank),
onPressed: () {
setState(() {
showCompletedNotes = !showCompletedNotes;
});
},
),
],
),
body: ListView.builder(
itemCount: filteredNotes.length,
itemBuilder: (context, index) {
final bool isDone = isNoteDone[notes.indexOf(filteredNotes[index])];
return ListTile(
title: Text(filteredNotes[index]),
leading: Checkbox(
value: isDone,
onChanged: (bool? value) {
setState(() {
isNoteDone[notes.indexOf(filteredNotes[index])] = value!;
});
},
),
);
},
),
floatingActionButton: FloatingActionButton(
onPressed: () {
_addNote();
},
child: Icon(Icons.add),
),
);
}

void _addNote() {
final TextEditingController textController = TextEditingController();

showDialog(
context: context,
builder: (context) {
return AlertDialog(
title: Text('Add a Note'),
content: TextField(controller: textController),
actions: <Widget>[
TextButton(
child: Text('Cancel'),
onPressed: () {
Navigator.of(context).pop();
},
),
TextButton(
child: Text('Add'),
onPressed: () {
setState(() {
String newNote = textController.text;
if (newNote.isNotEmpty) {
notes.add(newNote);
isNoteDone.add(false);
}
});
Navigator.of(context).pop();
},
),
],
);
},
);
}
}