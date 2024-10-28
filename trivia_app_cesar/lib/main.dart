import 'package:flutter/material.dart'; // Importa el paquete de Material Design para utilizar widgets y estilos.
import 'package:trivia_app_cesar/screens/trivia_home_screen.dart'; // Importa la pantalla principal de la trivia.

void main() => runApp(
    const MyApp()); // Función principal que inicia la aplicación y llama a MyApp.

class MyApp extends StatelessWidget {
  // Define un widget sin estado que representa la aplicación.
  const MyApp(
      {super.key}); // Constructor del widget, permite recibir una clave.

  @override
  Widget build(BuildContext context) {
    // Método que construye la interfaz del widget.
    return MaterialApp(
      // Crea una instancia de MaterialApp, que es el contenedor principal de la aplicación.
      theme: ThemeData(
        // Define el tema de la aplicación.
        brightness: Brightness.dark, // Establece el brillo del tema a oscuro.
        primaryColor:
            Colors.grey.shade200, // Establece el color primario del tema.
        hintColor: Colors
            .pinkAccent, // Color utilizado para sugerencias en campos de texto.
        colorScheme: ColorScheme.dark(
            primary: Colors.pink
                .shade600), // Define un esquema de color oscuro con un color primario personalizado.
      ),
      title:
          'Trivia App Cesar', // Establece el título de la aplicación, que se muestra en el sistema operativo.
      debugShowCheckedModeBanner:
          false, // Desactiva la banner de modo de depuración que aparece en la esquina superior derecha.
      home:
          const TriviaHomeScreen(), // Establece la pantalla inicial de la aplicación, en este caso, TriviaHomeScreen.
    );
  }
}
