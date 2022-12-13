import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'click_state.dart';

class ClickCubit extends Cubit<ClickState> {
  ClickCubit() : super(ClickInitial());

  int count = 0;

  void onClick(Brightness brightness, bool decrement) {
    int numForCount = 1;
    if(brightness == Brightness.dark) numForCount = 2;

    if(decrement) {
      count -= numForCount;
    }
    else {
      count += numForCount;
    }
    
    emit(Click(count));
  }
}
