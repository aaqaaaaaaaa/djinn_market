part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class OnSearchEvent extends SearchEvent {
  final String? searchText;

  OnSearchEvent({this.searchText});
}
class GetAllCetgoriesEvent extends SearchEvent {
  final String? searchText;

  GetAllCetgoriesEvent({this.searchText});
}
