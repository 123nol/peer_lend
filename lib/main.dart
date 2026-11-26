import 'package:flutter/material.dart';

void main() => runApp(const PeerLendApp());

class PeerLendApp extends StatelessWidget {
  const PeerLendApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'PeerLend',
    theme: ThemeData(colorSchemeSeed: const Color(0xFF176B58)),
    home: const Scaffold(body: Center(child: Text('PeerLend'))),
  );
}
