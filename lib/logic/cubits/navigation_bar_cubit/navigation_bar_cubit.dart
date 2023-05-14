// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'navigation_bar_state.dart';

class NavigationBarCubit extends Cubit<NavigationBarState> {
  NavigationBarCubit()
      : super(const NavigationBarInitial(
          initialPage: 0,
        ));

  void changePage({
    required int pageIndex,
  }) {
    emit(ChangedPageIndexState(currentIndex: pageIndex));
  }
}
