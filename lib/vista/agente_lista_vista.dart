import 'package:flutter/material.dart';
import '../modelo/agente_modelo.dart';
import '../controlador/agente_controlador.dart';
import 'AgenteEdicionForm.dart';

class AgentesVista extends StatefulWidget {
  @override
  _AgentesVistaState createState() => _AgentesVistaState();
}

class _AgentesVistaState extends State<AgentesVista> {
  final AgenteControlador _controller = AgenteControlador();


  List<Agente> _agentes = [];
  int _visibleCount = 0;

  @override
  void initState() {
    super.initState();
    _cargarAgentes();
  }

  Future<void> _cargarAgentes() async {
    try {
      final agentes = await _controller.obtenerAgentes();
      setState(() {
        _agentes = agentes;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  void _mostrarMasAgentes() {
    setState(() {
      if (_visibleCount < _agentes.length) {
        _visibleCount++;
      }
    });
  }
  void eliminarAgente(String uuid) async {
    final exito = await   _controller.eliminarAgente(uuid);
    if (exito) {
      setState(() {
        _agentes.removeWhere((agente) => agente.uuid == uuid);
      });
      mostrarMensaje("Agente eliminado con éxito");
      _visibleCount--;
    } else {
      mostrarMensaje("Error al eliminar agente");
    }
  }

  void mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  void actualizarAgente(String uuid) {
    final agente = _agentes.firstWhere((agente) => agente.uuid == uuid);
    showDialog(
      context: context,
      builder: (context) {
        return AgenteEdicionForm(
          agente: agente,
          onActualizar: (agenteActualizado) {
            setState(() {
              final index = _agentes.indexWhere((a) => a.uuid == agenteActualizado.uuid);
              if (index != -1) {
                _agentes[index] = agenteActualizado; // Reemplazar el agente en la lista
              }
            });
          },
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Agentes de Valorant",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red[50]!, Colors.red[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            _agentes.isEmpty
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: _mostrarMasAgentes,
                    child: Text(
                      "Agregar Agente",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent[100],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _visibleCount,
                    itemBuilder: (context, index) {
                      final agente = _agentes[index];

                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),

                        child: ListTile(
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.redAccent),
                                onPressed: () => eliminarAgente(agente.uuid),
                              ),
                              IconButton(
                                icon: Icon(Icons.update, color: Colors.redAccent),
                                onPressed: () => actualizarAgente(agente.uuid),
                              ),
                            ],
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          leading: CircleAvatar(
                            radius: 30,
                            child: ClipOval(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(agente.icono),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),


                          title: Text(
                            agente.nombre,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            agente.descripcion,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey[700]),
                          ),

                        ),

                      );
                    },
                  ),
                ),

              ],
            ),
            if (_visibleCount == 0)
              Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Presiona el botón para agregar agentes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}