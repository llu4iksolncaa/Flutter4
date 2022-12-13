part of 'change_theme_cubit.dart';

@immutable
abstract class ChangeThemeState {}

class ChangeThemeInitial extends ChangeThemeState {}

class ThemeState extends ChangeThemeState {
  final Brightness brightness;

  ThemeState(this.brightness);
}
