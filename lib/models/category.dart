import 'package:flutter/material.dart';

class Category {
  final Color color;
  final String title;
  final String id;
  const Category(
      {required this.title, required this.id, this.color = Colors.orange});
}
