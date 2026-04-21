abstract class NoteEvent {}

class LoadNotes extends NoteEvent {}

class AddNote extends NoteEvent {
  final String text;
  AddNote(this.text);
}

class LikeNote extends NoteEvent {
  final String id;
  LikeNote(this.id);
}