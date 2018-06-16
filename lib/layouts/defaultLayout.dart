
import 'package:flutter/material.dart';

Scaffold getDefaultLayout({
  String title,
  Widget body
}) {
  return new Scaffold(
    appBar: new AppBar(
      title: new Text(title)
    ),
    body: body,
    backgroundColor: Colors.black54,
  );
}