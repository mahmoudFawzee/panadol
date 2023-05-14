part of 'learning_material_bloc.dart';

@immutable
abstract class LearningMaterialState extends Equatable {
  const LearningMaterialState();
}

//?this is the initial state
class GetMaterialsLoadingState extends LearningMaterialState {
  const GetMaterialsLoadingState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetMaterialsErrorState extends LearningMaterialState {
  final String error;
  const GetMaterialsErrorState({
    required this.error,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        error,
      ];
}

//*this will be the state when the user open the app
class GotCategoryMaterialsState extends LearningMaterialState {
  final List<LearningMaterial>? learningMaterial;
  const GotCategoryMaterialsState({
    required this.learningMaterial,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        learningMaterial,
      ];
}

//*this is the state of start searching event which tell us that the materials had been gotten
class GotMaterialsForSearchState extends LearningMaterialState {
  const GotMaterialsForSearchState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//? here you already start searching in the list
class GotSearchedMaterialsState extends LearningMaterialState {
  final List<LearningMaterial>? learningMaterial;
  const GotSearchedMaterialsState({
    required this.learningMaterial,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        learningMaterial,
      ];
}
