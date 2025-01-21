import 'package:flutter/material.dart';
import 'agente_lista_vista.dart';
class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'VALORANT APP',
          style: TextStyle(
            fontFamily: 'ValorantFont',
            color: Colors.white,
            fontSize: 24,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        backgroundColor:  Colors.red,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration:  BoxDecoration(
              image: DecorationImage(
              image: AssetImage("assets/valorant.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'AGENTES',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
               SizedBox(height: 20),

              Padding(
                padding:  EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AgentesVista()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:Colors.red,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                        icon: Icon(Icons.people),
                        label: Text(
                          'Agentes',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  )

              ),
            ],
          ),
        ],
      ),
    );
  }

}
