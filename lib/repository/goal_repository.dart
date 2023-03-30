import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets1000_android/database/goal_db.dart';

final goalProvider = FutureProvider.autoDispose<Goal?>((ref) async {
  return Goal.fetchLast();
});
