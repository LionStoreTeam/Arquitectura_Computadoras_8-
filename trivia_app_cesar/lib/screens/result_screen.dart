import 'package:flutter/material.dart'; // Importa el paquete de Material Design para utilizar widgets y estilos.
import 'package:trivia_app_cesar/static/questions.dart'; // Importa la lista de preguntas desde un archivo estático.
import 'package:trivia_app_cesar/widgets/appbar_home.dart'; // Importa un widget personalizado para la AppBar.

class ResultsScreen extends StatelessWidget {
  // Define un widget sin estado para mostrar los resultados.
  final List<Question>
      questions; // Lista de preguntas pasadas a la pantalla de resultados.
  final List<int?>
      userAnswers; // Lista de respuestas del usuario pasadas a la pantalla.

  const ResultsScreen(
      {super.key,
      required this.questions,
      required this.userAnswers}); // Constructor que requiere las preguntas y respuestas.

  @override
  Widget build(BuildContext context) {
    // Método que construye la interfaz del widget.
    return Scaffold(
      // Crea una estructura básica para la pantalla.
      appBar:
          appBarBack(), // Llama al widget de AppBar personalizado para volver a la pantalla anterior.
      body: ListView.builder(
        // Usa un ListView.builder para crear una lista de resultados.
        scrollDirection:
            Axis.vertical, // Define la dirección de desplazamiento de la lista.
        padding: const EdgeInsets.all(12.0), // Define el padding de la pantalla
        itemCount: questions
            .length, // Establece el número de elementos en la lista basado en el número de preguntas.
        itemBuilder: (context, index) {
          // Método que construye cada elemento de la lista.
          return ListTile(
            // Widget que representa un elemento de la lista.
            title: Text(
              // Muestra la pregunta correspondiente.
              questions[index].question,
              style: const TextStyle(
                  fontWeight:
                      FontWeight.bold), // Estilo en negrita para la pregunta.
            ),
            subtitle: Column(
              // Columna para organizar la respuesta del usuario y la respuesta correcta.
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Alinea los hijos al inicio del eje transversal.
              children: [
                Text(// Muestra la respuesta seleccionada por el usuario.
                    "Tu respuesta: ${userAnswers[index] != null ? questions[index].answers[userAnswers[index]!].substring(3) : 'No respondida'}"),
                Text(
                  // Muestra la respuesta correcta.
                  "Respuesta correcta: ${questions[index].answers[questions[index].correctAnswerIndex].substring(3)}",
                  style: const TextStyle(
                      // Estilo para resaltar la respuesta correcta.
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
