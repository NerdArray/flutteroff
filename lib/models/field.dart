import 'package:json_annotation/json_annotation.dart';

part 'field.g.dart';

@JsonSerializable()
class Field {
  String? name; // field friendly name
  String? field; // field name

  Field(this.name, this.field);

  // factory methods for json (de)serialization.
  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);
  Map<String, dynamic> toJson() => _$FieldToJson(this);
}
