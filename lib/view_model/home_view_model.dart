import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lets1000_android/state/state.dart';
import 'package:lets1000_android/view_model/my_state_view_model.dart';

// viewでの参照はmyState
// stateを更新するときは、viewModelでmyStateNotifierを経由でmyStateの更新を行う

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModelProvider, MyState>(
  (ref) => HomeViewModelProvider(ref.watch(myStateProvider.notifier)),
);

class HomeViewModelProvider extends StateNotifier<MyState> {
  HomeViewModelProvider(
    MyStateNotifier myStateNotifier,
  ) : super(myStateNotifier.state);
}
