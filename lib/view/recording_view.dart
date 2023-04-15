import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lets1000_android/view/common/toast.dart';
import 'package:lets1000_android/view_model/recording_view_model.dart';

class RecordingView extends HookConsumerWidget {
  const RecordingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amount = useState<double?>(null);
    final dateIndex = useState<int>(0);

    final state = ref.watch(recordingViewModelProvider);
    final viewModel = ref.watch(recordingViewModelProvider.notifier);

    return Column(
      children: [
        const SizedBox(height: 100),
        dateChooseWidget(dateIndex),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 100,
              child: TextField(
                autofocus: true,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  amount.value = double.tryParse(value);
                },
              ),
            ),
            Text(state.goal?.unit ?? '')
          ],
        ),
        const SizedBox(height: 10),
        Text('${state.goal?.goal}しました！！'),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: amount.value == null
              ? null
              : () => onRegister(
                    context,
                    viewModel,
                    amount.value!,
                    dateIndex.value,
                  ),
          child: const Text('記録する'),
        ),
      ],
    );
  }

  Row dateChooseWidget(ValueNotifier<int> dateIndex) {
    void updateDate(int? i) => dateIndex.value = i!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Radio<int>(
              value: 0,
              groupValue: dateIndex.value,
              onChanged: updateDate,
            ),
            const Text('今日')
          ],
        ),
        Row(
          children: [
            Radio<int>(
              value: 1,
              groupValue: dateIndex.value,
              onChanged: updateDate,
            ),
            const Text('昨日')
          ],
        ),
      ],
    );
  }

  void onRegister(
    BuildContext context,
    RecordingViewModelProvider viewModel,
    double amount,
    int dateIndex,
  ) {
    viewModel.insertRecord(amount, dateIndex);

    Navigator.of(context).pop();
    showToast(FToast().init(context), viewModel.toastMessages());
  }
}
