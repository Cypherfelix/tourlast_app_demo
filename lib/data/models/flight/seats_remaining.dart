import 'package:json_annotation/json_annotation.dart';

part 'seats_remaining.g.dart';

@JsonSerializable()
class SeatsRemaining {
  const SeatsRemaining({required this.belowMinimum, required this.number});

  @JsonKey(name: 'BelowMinimum')
  final bool belowMinimum;

  @JsonKey(name: 'Number')
  final int number;

  factory SeatsRemaining.fromJson(Map<String, dynamic> json) =>
      _$SeatsRemainingFromJson(json);
  Map<String, dynamic> toJson() => _$SeatsRemainingToJson(this);
}
