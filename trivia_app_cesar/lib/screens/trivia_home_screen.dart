import 'package:flutter/material.dart'; // Importa el paquete de Material Design para utilizar widgets y estilos.
import 'package:trivia_app_cesar/screens/result_screen.dart'; // Importa la pantalla que muestra los resultados.
import 'package:trivia_app_cesar/static/questions.dart'; // Importa la lista de preguntas desde un archivo estático.
import 'package:trivia_app_cesar/widgets/appbar_home.dart'; // Importa un widget personalizado para la AppBar.

class TriviaHomeScreen extends StatefulWidget {
  // Define un widget con estado para la pantalla principal de trivia.
  const TriviaHomeScreen(
      {super.key}); // Constructor del widget, permite recibir una clave.

  @override
  TriviaScreenState createState() =>
      TriviaScreenState(); // Crea el estado asociado a este widget.
}

class TriviaScreenState extends State<TriviaHomeScreen> {
  // Clase que maneja el estado de TriviaHomeScreen.
  int currentQuestionIndex = 0; // Índice de la pregunta actual.
  int?
      selectedAnswerIndex; // Índice de la respuesta seleccionada por el usuario.
  List<int?> userAnswers = List.filled(questions.length,
      null); // Lista para almacenar las respuestas del usuario.

  void nextQuestion() {
    // Método que avanza a la siguiente pregunta.
    if (currentQuestionIndex < questions.length - 1) {
      // Verifica si hay más preguntas.
      setState(() {
        // Notifica que el estado ha cambiado.
        currentQuestionIndex++; // Aumenta el índice de la pregunta actual.
        selectedAnswerIndex = null; // Reinicia la respuesta seleccionada.
      });
    } else {
      // Si es la última pregunta, muestra los resultados.
      showResults();
    }
  }

  void showResults() {
    // Método que calcula y muestra los resultados al finalizar el cuestionario.
    int score = 0; // Inicializa el puntaje.
    for (int i = 0; i < questions.length; i++) {
      // Recorre todas las preguntas.
      if (userAnswers[i] == questions[i].correctAnswerIndex) {
        // Verifica si la respuesta del usuario es correcta.
        score++; // Incrementa el puntaje por cada respuesta correcta.
      }
    }
    double percentage = (score / questions.length) *
        100; // Calcula el porcentaje de respuestas correctas.

    showDialog(
      // Muestra un diálogo con los resultados.
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Resultados"), // Título del diálogo.
        content: Text(
            "Tu puntaje es: ${percentage.toStringAsFixed(2)}%"), // Muestra el puntaje obtenido.
        actions: [
          // Acciones disponibles en el diálogo.
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el diálogo.
              resetQuiz(); // Reinicia el cuestionario.
            },
            child: const Text(
                "Volver a intentarlo"), // Texto del botón para reiniciar.
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                // Navega a la pantalla de resultados.
                builder: (context) => ResultsScreen(
                  questions:
                      questions, // Pasa la lista de preguntas a la pantalla de resultados.
                  userAnswers: userAnswers, // Pasa las respuestas del usuario.
                ),
              ));
            },
            child: const Text(
                "Ver respuestas"), // Texto del botón para ver respuestas.
          ),
        ],
      ),
    );
  }

  void resetQuiz() {
    // Método que reinicia el estado del cuestionario.
    setState(() {
      // Notifica que el estado ha cambiado.
      currentQuestionIndex = 0; // Reinicia el índice de la pregunta actual.
      selectedAnswerIndex = null; // Reinicia la respuesta seleccionada.
      userAnswers = List.filled(
          questions.length, null); // Reinicia la lista de respuestas.
    });
  }

  @override
  Widget build(BuildContext context) {
    // Método que construye la interfaz del widget.
    return Scaffold(
      // Crea una estructura básica para la pantalla.
      appBar: appBarHome(), // Llama al widget de AppBar personalizado.
      body: SingleChildScrollView(
        // Permite el desplazamiento en la pantalla.
        child: Padding(
          padding: const EdgeInsets.all(
              16.0), // Añade un margen alrededor del contenido.
          child: Column(
            // Usa un Column para organizar los elementos verticalmente.
            crossAxisAlignment: CrossAxisAlignment
                .stretch, // Estira los hijos a lo largo del eje transversal.
            children: [
              Text(
                questions[currentQuestionIndex]
                    .question, // Muestra la pregunta actual.
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold), // Estilo del texto.
              ),
              ...List.generate(
                // Genera una lista de RadioListTile para las respuestas.
                questions[currentQuestionIndex].answers.length,
                (index) {
                  return RadioListTile<int>(
                    // Widget que permite seleccionar una opción.
                    title: Text(questions[currentQuestionIndex]
                        .answers[index]), // Muestra la opción de respuesta.
                    value: index, // Valor de la respuesta.
                    groupValue:
                        selectedAnswerIndex, // Grupo de la respuesta seleccionada.
                    onChanged: (value) {
                      // Callback cuando se selecciona una respuesta.
                      setState(() {
                        selectedAnswerIndex =
                            value; // Actualiza la respuesta seleccionada.
                        userAnswers[currentQuestionIndex] =
                            value; // Guarda la respuesta en la lista.
                      });
                    },
                  );
                },
              ),
              const SizedBox(
                  height:
                      20), // Espacio entre la lista de respuestas y el botón.
              ElevatedButton(
                onPressed: selectedAnswerIndex == null
                    ? null
                    : nextQuestion, // Deshabilita el botón si no hay respuesta seleccionada.
                child: Text(currentQuestionIndex <
                        questions.length -
                            1 // Cambia el texto del botón según la pregunta actual.
                    ? "Siguiente"
                    : "Terminar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
