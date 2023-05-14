enum FieldsType {
  phoneNumber,
  name,
  password,
}

enum LearningMaterialType {
  course,
  article,
  book,
}

const Map<LearningMaterialType, String> materialsTypes = {
  LearningMaterialType.course: "courses",
  LearningMaterialType.article: "article",
  LearningMaterialType.book: "books"
};
