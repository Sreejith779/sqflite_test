import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite_test/database/db.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
 on<HomeInitialEvent>(homeInitialEvent);
 on<HomeAddNotes>(homeAddNotes);
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    emit(HomeLoadedState());
  }

  FutureOr<void> homeAddNotes(HomeAddNotes event, Emitter<HomeState> emit) async{

    int id = await SqlHelper.addNote(event.title,event.description);
    emit(AddNoteActionState(id: id));

  }
}
