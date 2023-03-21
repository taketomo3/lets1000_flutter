import 'package:flutter/material.dart';

void showAlmostFullModal(
    BuildContext context, Widget widget, VoidCallback updateState) {
  showModalBottomSheet(
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
  ).then((value) {
    updateState();
  });
}
