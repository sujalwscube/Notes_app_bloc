import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp_bloc/dbhelper.dart';
import 'package:notesapp_bloc/notesbloc/notesevents.dart';
import 'package:notesapp_bloc/notesbloc/notesstate.dart';

class NoteBloc extends Bloc<NotesEvent,NotesState>{
  DB_helper db;

  NoteBloc({required this.db}):super(NotesInitialState()){
    on<AddNotesEvent>((event,emit)async{
      emit(NotesLoading());
      bool check=await db.addNotes(event.newnotes);
      if(check){
        var arrnotes=await db.fetchAllNotes();
        emit(NotesLoaded(arrnotes: arrnotes));
      }
    });
  }
}