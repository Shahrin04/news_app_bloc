class SourceModel{
  final id;
  final name;
  final description;
  final url;
  final category;
  final language;
  final country;

  SourceModel({this.id, this.name, this.description, this.url, this.category, this.language, this.country});

  factory SourceModel.fromJson(Map<String, dynamic> json){
    return SourceModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      url: json['url'],
      category: json['category'],
      language: json['language'],
      country: json['country'],
    );
  }
}