import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'change_theme_state.dart';

class ChangeThemeCubit extends Cubit<ChangeThemeState> {
  ChangeThemeCubit() : super(ChangeThemeInitial());

  void onClick(Brightness brightness) {
    if(brightness == Brightness.dark) {
      emit(ThemeState(Brightness.light));
      return;
    }
    emit(ThemeState(Brightness.dark));
  }
}


