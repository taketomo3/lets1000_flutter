// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Goal _$$_GoalFromJson(Map<String, dynamic> json) => _$_Goal(
      id: json['id'] as int?,
      goal: json['goal'] as String,
      unit: json['unit'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$_GoalToJson(_$_Goal instance) => <String, dynamic>{
      'id': instance.id,
      'goal': instance.goal,
      'unit': instance.unit,
      'created_at': instance.createdAt.toIso8601String(),
    };
