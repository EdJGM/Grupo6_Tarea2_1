import 'package:flutter/material.dart';
import 'vista/agente_lista_vista.dart';
import 'vista/pantalla_principal_vista.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valorant Agents',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: PantallaPrincipal(),
    );
  }
}
