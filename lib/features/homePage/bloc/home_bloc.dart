import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite_test/database/db.dart';
import 'package:sqflite_test/models/dataList.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
 on<HomeInitialEvent>(homeInitialEvent);
 on<HomeAddNotes>(homeAddNotes);
  }



  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit)async{

    emit(HomeLoadingState());
    final data = await SqlHelper.getData();
    final List<DataModel>allData = data.map((e) => DataModel(id: e['id'], title: e['title'], description: e['description'])).toList();
    print(data);
    emit(HomeLoadedState(allData: allData));
  }

  FutureOr<void> homeAddNotes(HomeAddNotes event, Emitter<HomeState> emit) async{

    int id = await SqlHelper.addNote(event.title,event.description);
    emit(AddNoteActionState(id: id));
    final data = await SqlHelper.getData();
    final List<DataModel>allData = data.map((e) => DataModel(id: e['id'], title: e['title'], description: e['description'])).toList();

    emit(HomeLoadedState(allData: allData));


  }

}
