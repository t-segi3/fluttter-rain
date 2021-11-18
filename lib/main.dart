// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'utils/geo_helper.dart';

import 'package:outrain/pages/home.dart';
import 'package:outrain/pages/loading.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}
