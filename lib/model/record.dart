import 'package:freezed_annotation/freezed_annotation.dart';

part 'record.freezed.dart';
part 'record.g.dart';

@freezed
abstract class Record with _$Record {
  const factory Record({
    int? id,
    required double amount,
    required DateTime date,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Record;

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
}
