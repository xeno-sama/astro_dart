import 'dart:convert';

import 'package:csv/csv.dart';

import 'dart:io';

void main() async {
  final input = File('countries.csv').openRead();

  final fields = await input
      .transform(utf8.decoder)
      .transform(CsvToListConverter())
      .toList();

  for (var i = 0; i < fields.length; i++) {
    print(" '${fields[i]}' : '${fields[i]}' ");
  }
}
