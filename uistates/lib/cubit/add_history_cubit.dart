import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'add_history_state.dart';

class AddHistoryCubit extends Cubit<AddHistoryState> {
  AddHistoryCubit() : super(AddHistoryInitial());

  void onClick(List<Text> history, int counter, Brightness brightness) {
    
    String theme = brightness == Brightness.dark ? "Темная" : "Светлая";

    String text = DateTime.now().toString() + " " + counter.toString() + " " + theme; 

    history.insert(0, Text(text));

    emit(History(history));
  }
}
