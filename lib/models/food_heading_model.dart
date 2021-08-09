class FoodHeadingModel {
  final String id, title, subtitle;
  FoodHeadingModel(
      {required this.id, required this.title, required this.subtitle});
  factory FoodHeadingModel.fromMap(Map<String, dynamic> mapedData) {
    return FoodHeadingModel(
        id: mapedData['Id'],
        subtitle: mapedData['Sub-title'],
        title: mapedData['Title']);
  }
}
