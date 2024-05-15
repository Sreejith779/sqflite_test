import 'package:flutter/material.dart';

List<Map<String,dynamic>>dataList= [];


class DataModel{
  final int id;
  final String title;
  final String description;

  DataModel({required this.id, required this.title, required this.description});
}