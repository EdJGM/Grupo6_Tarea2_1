import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modelo/agente_modelo.dart';

class AgenteControlador {
  final String _baseUrl = "https://valorant-api.com/v1/agents";

  Future<List<Agente>> obtenerAgentes() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Agente.fromJson(json)).toList();
    } else {
      throw Exception("Error al obtener agentes");
    }
  }
  Future<bool> eliminarAgente(String uuid) async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }
}
