
import 'package:flutter/material.dart';

Scaffold getDefaultLayout({
  String title,
  Widget body,
  actions
}) {
  return new Scaffold(
    appBar: new AppBar(
      title: new Text(title),
      actions: actions,
    ),
    body: body,
    backgroundColor: Colors.black54,
  );
}