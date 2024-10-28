import 'package:flutter/material.dart'; // Importa el paquete de Material Design para utilizar widgets y estilos.
import 'package:flutter/services.dart'; // Importa el paquete para interactuar con los servicios del sistema.

/// Widget AppBar para mostrar un AlertDialog al salir de la aplicación.
AppBar appBarHome() {
  return AppBar(
    title: const Text(
      // Título de la AppBar.
      "Mi Trivia App",
      style: TextStyle(
        color: Colors.white, // Color del texto del título.
      ),
    ),
    centerTitle: true, // Centra el título en la AppBar.
    elevation: 0, // Elimina la sombra de la AppBar.
    backgroundColor: Colors.pink.shade600, // Color de fondo de la AppBar.
    leading: Builder(
      // Permite crear un botón de retroceso.
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(
            Icons.arrow_back_sharp, // Icono de flecha hacia atrás.
            color: Colors.white, // Color del icono.
          ),
          onPressed: () =>
              _onBackButtonPressed(context), // Llama a la función al presionar.
        );
      },
    ),
  );
}

/// Método para mostrar un AlertDialog para salir de la aplicación.
void _onBackButtonPressed(BuildContext context) async {
  return showDialog(
    context: context, // Contexto actual para mostrar el diálogo.
    builder: (BuildContext context) {
      // Constructor del diálogo.
      return AlertDialog(
        title: const Text("Salir de la aplicación"), // Título del diálogo.
        content: const Text(
            "¿Quieres salir de la aplicación?"), // Contenido del diálogo.
        actions: [
          // Acciones disponibles en el diálogo.
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(false); // Cierra el diálogo sin hacer nada.
            },
            child: const Text("No"), // Botón "No".
          ),
          TextButton(
            onPressed: () => // Botón "Sí" que cierra la aplicación.
                SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
            child: const Text("Si"), // Texto del botón "Si".
          ),
        ],
      );
    },
  );
}

/// Widget AppBar para retroceder a la pantalla anterior.
AppBar appBarBack() {
  return AppBar(
    title: const Text(
      // Título de la AppBar.
      "Página anterior",
      style: TextStyle(
        color: Colors.white, // Color del texto del título.
      ),
    ),
    centerTitle: true, // Centra el título en la AppBar.
    elevation: 0, // Elimina la sombra de la AppBar.
    backgroundColor: Colors.pink.shade600, // Color de fondo de la AppBar.
    leading: Builder(
      // Permite crear un botón de retroceso.
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded, // Icono de flecha hacia atrás.
            color: Colors.white, // Color del icono.
          ),
          onPressed: () =>
              Navigator.of(context).pop(), // Navega a la pantalla anterior.
        );
      },
    ),
  );
}
