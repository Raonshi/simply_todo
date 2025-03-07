part of 'home_bloc.dart';

sealed class HomeEvent {
  const HomeEvent();
}

final class ChangeHomeTab extends HomeEvent {
  final int _idx;
  int get idx => _idx;

  const ChangeHomeTab(this._idx);
}
