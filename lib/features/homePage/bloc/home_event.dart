part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent{}

class HomeAddNotes extends HomeEvent{
  final String title;
  final String description;

  HomeAddNotes({required this.title, required this.description});
}

class HomeUpdateNotes extends HomeEvent{
  final String title;
  final String description;

  HomeUpdateNotes({required this.title, required this.description});
}