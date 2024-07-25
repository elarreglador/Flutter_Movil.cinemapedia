import 'package:flutter/material.dart';

// Pantalla de carga de la aplicacion
class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      ".",
      "..",
      "...",
      "....",
      ".....",
      "......"
    ];

    // Envia al stream cada pocas milesimas uno de los mensajes anteriores
    return Stream.periodic(const Duration(milliseconds: 1500), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    //Cuerpo principal
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Texto y barra de carga redonda
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: Image.asset('assets/logo.png'),
          ),
          const Text("Estamos haciendo algunas tareas ..."),
          const SizedBox(height: 10),
          // Frases de carga
          StreamBuilder(
            stream: getLoadingMessages(), 
            builder: (context, snapshot) {
              // si no hay frases de carga aun
              if (!snapshot.hasData) return const Text("Cargando ...");
              // Muestra las frases
              return Text(snapshot.data!);
            }
          ),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
        ],
      ),
    );
  }
}
