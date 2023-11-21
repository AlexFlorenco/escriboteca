import 'package:flutter/material.dart';

import 'pages/home_page.dart';

class Escriboteca extends StatelessWidget {
  const Escriboteca({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Escriboteca',
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const HomePage(),
    );
  }
}
