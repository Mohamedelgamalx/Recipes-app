class Recipe {
  late int id;
  late String title;
  late String image;

  Recipe({required this.id,required this.title,required this.image});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
        id: json['id'],
        title: json['title'],
        image: json['body']
    );
  }
}