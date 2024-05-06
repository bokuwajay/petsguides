import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';

class AutoCompleteModel extends AutoCompleteEntity {
  AutoCompleteModel(
      {description,
      matchedSubstrings,
      placeId,
      reference,
      structuredFormatting,
      terms,
      types})
      : super(
          description: description,
          matchedSubstrings: matchedSubstrings,
          placeId: placeId,
          reference: reference,
          structuredFormatting: structuredFormatting,
          terms: terms,
          types: types,
        );

  factory AutoCompleteModel.fromJson(Map<String, dynamic> json) {
    List<MatchedSubstrings>? _matchedSubstrings;
    List<Terms>? _terms;
    if (json['matched_substrings'] != null) {
      _matchedSubstrings = [];
      json['matched_substrings'].forEach((v) {
        _matchedSubstrings!.add(MatchedSubstrings.fromJson(v));
      });
    }

    if (json['terms'] != null) {
      _terms = [];
      json['terms'].forEach((v) {
        _terms!.add(Terms.fromJson(v));
      });
    }

    return AutoCompleteModel(
      description: json['description'],
      matchedSubstrings: _matchedSubstrings,
      placeId: json['place_id'],
      reference: json['reference'],
      structuredFormatting: json['structured_formatting'] != null
          ? StructuredFormatting.fromJson(json['structured_formatting'])
          : null,
      terms: _terms,
      types: json['types'].cast<String>(),
    );
  }
}
