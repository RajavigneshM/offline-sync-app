import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../models/note_model.dart';
import '../models/sync_item.dart';
import '../services/hive_service.dart';
import '../services/sync_service.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final uuid = Uuid();
  final SyncService syncService = SyncService();

  NoteBloc() : super(NoteState([])) {
    on<LoadNotes>(_loadNotes);
    on<AddNote>(_addNote);
    on<LikeNote>(_likeNote);
  }

  void _loadNotes(LoadNotes event, Emitter emit) {
    final notes = HiveService.notesBox.values
        .map((e) => Note.fromJson(Map.from(e)))
        .toList();

    emit(NoteState(notes));
  }

  Future<void> _addNote(AddNote event, Emitter emit) async {
    final note = Note(
      id: uuid.v4(),
      content: event.text,
      isLiked: false,
      updatedAt: DateTime.now(),
    );

    await HiveService.notesBox.put(note.id, note.toJson());

    final syncItem = SyncItem(
      id: uuid.v4(),
      type: SyncActionType.add,
      payload: note.toJson(),
    );

    await HiveService.queueBox.put(syncItem.id, syncItem.toJson());

    add(LoadNotes());
    syncService.processQueue();
  }

  Future<void> _likeNote(LikeNote event, Emitter emit) async {
    final data = HiveService.notesBox.get(event.id);
    final note = Note.fromJson(Map.from(data));

    final updated = Note(
      id: note.id,
      content: note.content,
      isLiked: !note.isLiked,
      updatedAt: DateTime.now(),
    );

    await HiveService.notesBox.put(updated.id, updated.toJson());

    final syncItem = SyncItem(
      id: uuid.v4(),
      type: SyncActionType.like,
      payload: updated.toJson(),
    );

    await HiveService.queueBox.put(syncItem.id, syncItem.toJson());

    add(LoadNotes());
    syncService.processQueue();
  }
}