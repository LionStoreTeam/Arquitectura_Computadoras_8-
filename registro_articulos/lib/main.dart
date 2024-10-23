import 'package:flutter/material.dart';
import 'package:registro_articulos/nuevos_articulos/nuevo_registro.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NuevoRegistroArticulo(),
    );
  }
}
