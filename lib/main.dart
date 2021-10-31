import 'package:flutter/material.dart';
import './widgets/operations_screen.dart';

void main() => runApp(const MyApp());

// Displays a list of endpoints at https://foaas.com,
// allows the user to pick an endpoint and call it
// with the required parameter values of their choosing,
// then displays the result.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Flutter Off', home: FOAASOperationsList());
  }
}
