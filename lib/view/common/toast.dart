import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(FToast fToast, List<String> textCandidates) {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check),
        const SizedBox(width: 12.0),
        Text(_getRandomToastWord(textCandidates)),
      ],
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.CENTER,
    toastDuration: const Duration(seconds: 2),
  );
}

String _getRandomToastWord(List<String> toastWords) {
  final random = Random();
  final randomIndex = random.nextInt(toastWords.length);
  return toastWords[randomIndex];
}
