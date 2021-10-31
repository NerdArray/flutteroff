import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'insult.g.dart';

// Query the API with the given parameters.
// https://foaas.com/{queryString}
Future<Insult> fetchInsult(String queryString) async {
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  final response = await http.get(Uri.parse('https://foaas.com' + queryString),
      headers: headers);

  if (response.statusCode == 200) {
    // deserialize the result to an Insult object and return it.
    return Insult.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('You\'ve got errors!');
  }
}

@JsonSerializable()
class Insult {
  final String message; // the insult
  final String subtitle; // the value of ':from' in the request

  Insult({required this.message, required this.subtitle});

  // factory methods for json (de)serialization.
  factory Insult.fromJson(Map<String, dynamic> json) => _$InsultFromJson(json);
  Map<String, dynamic> toJson() => _$InsultToJson(this);
}
