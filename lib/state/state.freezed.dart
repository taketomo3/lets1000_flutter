// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MyState {
  Goal? get goal => throw _privateConstructorUsedError;
  List<Record> get recordList => throw _privateConstructorUsedError;
  int get totalRecordAmount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyStateCopyWith<MyState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyStateCopyWith<$Res> {
  factory $MyStateCopyWith(MyState value, $Res Function(MyState) then) =
      _$MyStateCopyWithImpl<$Res, MyState>;
  @useResult
  $Res call({Goal? goal, List<Record> recordList, int totalRecordAmount});

  $GoalCopyWith<$Res>? get goal;
}

/// @nodoc
class _$MyStateCopyWithImpl<$Res, $Val extends MyState>
    implements $MyStateCopyWith<$Res> {
  _$MyStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goal = freezed,
    Object? recordList = null,
    Object? totalRecordAmount = null,
  }) {
    return _then(_value.copyWith(
      goal: freezed == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as Goal?,
      recordList: null == recordList
          ? _value.recordList
          : recordList // ignore: cast_nullable_to_non_nullable
              as List<Record>,
      totalRecordAmount: null == totalRecordAmount
          ? _value.totalRecordAmount
          : totalRecordAmount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GoalCopyWith<$Res>? get goal {
    if (_value.goal == null) {
      return null;
    }

    return $GoalCopyWith<$Res>(_value.goal!, (value) {
      return _then(_value.copyWith(goal: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MyStateCopyWith<$Res> implements $MyStateCopyWith<$Res> {
  factory _$$_MyStateCopyWith(
          _$_MyState value, $Res Function(_$_MyState) then) =
      __$$_MyStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Goal? goal, List<Record> recordList, int totalRecordAmount});

  @override
  $GoalCopyWith<$Res>? get goal;
}

/// @nodoc
class __$$_MyStateCopyWithImpl<$Res>
    extends _$MyStateCopyWithImpl<$Res, _$_MyState>
    implements _$$_MyStateCopyWith<$Res> {
  __$$_MyStateCopyWithImpl(_$_MyState _value, $Res Function(_$_MyState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goal = freezed,
    Object? recordList = null,
    Object? totalRecordAmount = null,
  }) {
    return _then(_$_MyState(
      goal: freezed == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as Goal?,
      recordList: null == recordList
          ? _value._recordList
          : recordList // ignore: cast_nullable_to_non_nullable
              as List<Record>,
      totalRecordAmount: null == totalRecordAmount
          ? _value.totalRecordAmount
          : totalRecordAmount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_MyState implements _MyState {
  const _$_MyState(
      {this.goal = null,
      final List<Record> recordList = const [],
      this.totalRecordAmount = 0})
      : _recordList = recordList;

  @override
  @JsonKey()
  final Goal? goal;
  final List<Record> _recordList;
  @override
  @JsonKey()
  List<Record> get recordList {
    if (_recordList is EqualUnmodifiableListView) return _recordList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recordList);
  }

  @override
  @JsonKey()
  final int totalRecordAmount;

  @override
  String toString() {
    return 'MyState(goal: $goal, recordList: $recordList, totalRecordAmount: $totalRecordAmount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyState &&
            (identical(other.goal, goal) || other.goal == goal) &&
            const DeepCollectionEquality()
                .equals(other._recordList, _recordList) &&
            (identical(other.totalRecordAmount, totalRecordAmount) ||
                other.totalRecordAmount == totalRecordAmount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, goal,
      const DeepCollectionEquality().hash(_recordList), totalRecordAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MyStateCopyWith<_$_MyState> get copyWith =>
      __$$_MyStateCopyWithImpl<_$_MyState>(this, _$identity);
}

abstract class _MyState implements MyState {
  const factory _MyState(
      {final Goal? goal,
      final List<Record> recordList,
      final int totalRecordAmount}) = _$_MyState;

  @override
  Goal? get goal;
  @override
  List<Record> get recordList;
  @override
  int get totalRecordAmount;
  @override
  @JsonKey(ignore: true)
  _$$_MyStateCopyWith<_$_MyState> get copyWith =>
      throw _privateConstructorUsedError;
}
