import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.g.dart';

final class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeEvent>(_handleEvents);
  }

  void _handleEvents(HomeEvent event, Emitter<HomeState> emit) =>
      switch (event) {
        ChangeHomeTab e => _changeHomeTab(e, emit),
      };

  void _changeHomeTab(ChangeHomeTab event, Emitter<HomeState> emit) {
    emit(state.copyWith(idx: event.idx));
  }
}
