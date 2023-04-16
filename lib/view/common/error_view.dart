import 'package:flutter/material.dart';

Widget errorView(Object error) {
  return Center(
    child: Text('Oops, something unexpected happened $error'),
  );
}
