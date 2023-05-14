part of 'navigation_bar_cubit.dart';

@immutable
abstract class NavigationBarState extends Equatable {
  const NavigationBarState();
}

class NavigationBarInitial extends NavigationBarState {
  final int initialPage;
  const NavigationBarInitial({required this.initialPage,});
  @override
  // TODO: implement props
  List<Object?> get props => [initialPage];
}

class ChangedPageIndexState extends NavigationBarState {
  final int currentIndex;
  const ChangedPageIndexState({
    required this.currentIndex,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [currentIndex];
}
