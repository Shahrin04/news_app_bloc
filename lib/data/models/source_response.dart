import 'package:news_app/data/models/source_model.dart';

class SourceResponse {
  final List<SourceModel> sources;
  final String error;

  SourceResponse({this.sources, this.error});

  factory SourceResponse.fromJason(Map<String, dynamic> json) {
    return SourceResponse(
        error: '',
        sources: (json['sources'] as List)
            .map((i) => SourceModel.fromJson(i))
            .toList());
  }

  factory SourceResponse.withError(String errorValue) {
    return SourceResponse(sources: [], error: errorValue);
  }
}
