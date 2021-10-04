import 'package:news_app/Data/models/source_model.dart';

class SourceResponse {
  final List<SourceModel> sources;

  SourceResponse({this.sources});

  factory SourceResponse.fromJason(Map<String, dynamic> json) {
    return SourceResponse(
        sources: (json['sources'] as List)
            .map((i) => SourceModel.fromJson(i))
            .toList());
  }
}
