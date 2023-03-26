import 'package:flutter/material.dart';

Future<void> showAlmostFullModal(
  BuildContext context,
  Widget widget,
  VoidCallback updateState,
) async {
  await showModalBottomSheet<Container>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        margin: const EdgeInsets.only(top: 64),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: widget,
      );
    },
  );
  updateState();
}
