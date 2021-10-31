import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'field.dart';

part 'insult_operation.g.dart';

// return a list of InsultOperations that represent
// available API endpoints on FOAAS.com.
// https://foaas.com/operations
Future<List<InsultOperation>> fetchOperations() async {
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  final response = await http.get(Uri.parse('https://foaas.com/operations'),
      headers: headers);

  if (response.statusCode == 200) {
    // deserialize the json to a list of InsultOperations
    final ops = List<InsultOperation>.from(json
        .decode(response.body)
        .map((data) => InsultOperation.fromJson(data)));
    return ops;
  } else {
    throw Exception('You\'ve got errors!');
  }
}

@JsonSerializable(explicitToJson: true)
class InsultOperation {
  String name; // endpoint name
  String url; // query string example
  List<Field>? fields; // required parameters for the API call

  InsultOperation(this.name, this.url, this.fields);

  // factory methods for json (de)serialization.
  factory InsultOperation.fromJson(Map<String, dynamic> json) =>
      _$InsultOperationFromJson(json);
  Map<String, dynamic> toJson() => _$InsultOperationToJson(this);
}
