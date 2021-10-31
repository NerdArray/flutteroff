// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insult_operation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsultOperation _$InsultOperationFromJson(Map<String, dynamic> json) =>
    InsultOperation(
      json['name'] as String,
      json['url'] as String,
      (json['fields'] as List<dynamic>?)
          ?.map((e) => Field.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InsultOperationToJson(InsultOperation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'fields': instance.fields?.map((e) => e.toJson()).toList(),
    };
