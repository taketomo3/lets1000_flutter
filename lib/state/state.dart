import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lets1000_android/model/goal.dart';
import 'package:lets1000_android/model/record.dart';

part 'state.freezed.dart';

@freezed
abstract class MyState with _$MyState {
  const factory MyState({
    @Default(null) Goal? goal,
    @Default([]) List<Record> recordList,
    @Default(0) int totalRecordAmount,
  }) = _MyState;
}
