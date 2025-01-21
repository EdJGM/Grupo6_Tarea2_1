import 'package:flutter/material.dart';
import '../modelo/agente_modelo.dart';

class AgenteEdicionForm extends StatefulWidget {
  final Agente agente;
  final Function(Agente) onActualizar;

  AgenteEdicionForm({required this.agente, required this.onActualizar});

  @override
  _AgenteEdicionFormState createState() => _AgenteEdicionFormState();
}

class _AgenteEdicionFormState extends State<AgenteEdicionForm> {
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.agente.nombre);
    _descripcionController = TextEditingController(text: widget.agente.descripcion);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Editar Agente"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nombreController,
            decoration: InputDecoration(labelText: "Nombre del Agente"),
            onChanged: (value) {
            },
          ),
          TextField(
            controller: _descripcionController,
            decoration: InputDecoration(labelText: "Descripción del Agente"),
            onChanged: (value) {
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancelar"),
        ),
        TextButton(
          onPressed: () {
            Agente agenteActualizado = Agente(
              uuid: widget.agente.uuid,
              nombre: _nombreController.text,
              descripcion: _descripcionController.text,
              icono: widget.agente.icono,
            );
            widget.onActualizar(agenteActualizado);
            Navigator.of(context).pop();
          },
          child: Text("Guardar"),
        ),
      ],
    );
  }
}
