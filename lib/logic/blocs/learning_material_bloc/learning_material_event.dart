part of 'learning_material_bloc.dart';

@immutable
abstract class LearningMaterialEvent extends Equatable {
  const LearningMaterialEvent();
  @override
  List<Object?> get props => [];
}

class GetCategoryMaterialsEvent extends LearningMaterialEvent {
  const GetCategoryMaterialsEvent({
    required this.learningMaterialType,
    required this.category,
  });
  final LearningMaterialType learningMaterialType;
  final String category;
  @override
  List<Object?> get props => [
        learningMaterialType,
        category,
      ];
}

class StartSearchEvent extends LearningMaterialEvent {
  const StartSearchEvent({
    required this.learningMaterialType,
  });
  final LearningMaterialType learningMaterialType;

  @override
  List<Object?> get props => [
        learningMaterialType,
      ];
}

class SearchInMaterialsEvent extends LearningMaterialEvent {
  final String searchKey;
  const SearchInMaterialsEvent({
    required this.searchKey,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [searchKey];
}
