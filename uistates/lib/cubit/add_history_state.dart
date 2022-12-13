part of 'add_history_cubit.dart';

@immutable
abstract class AddHistoryState {}

class AddHistoryInitial extends AddHistoryState {}

class History extends AddHistoryState {
  
  final List<Text> history;

  History(this.history);
}