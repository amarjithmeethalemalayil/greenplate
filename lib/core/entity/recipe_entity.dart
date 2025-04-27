class RecipeEntity {
  final int id;
  final String title;
  final String imageUrl;
  final int readyInMinutes;

  const RecipeEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.readyInMinutes,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': imageUrl,
      'readyInMinutes': readyInMinutes,
    };
  }
}
