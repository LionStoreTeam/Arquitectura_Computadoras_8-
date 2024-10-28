class Question {
  // Pregunta del cuestionario.
  final String question;

  // Lista de posibles respuestas para la pregunta.
  final List<String> answers;

  // Índice de la respuesta correcta en la lista de respuestas.
  final int correctAnswerIndex;

  // Constructor que inicializa la pregunta, las respuestas y el índice de la respuesta correcta.
  Question(this.question, this.answers, this.correctAnswerIndex);
}

// Lista de preguntas que se utilizarán en el cuestionario.
final List<Question> questions = [
  // Primera pregunta sobre la capital de Francia.
  Question(
    "¿Cuál es la capital de Francia?",
    [
      "A) Berlín",
      "B) Madrid",
      "C) París",
      "D) Lisboa"
    ], // Opciones de respuesta
    2, // Índice de la respuesta correcta (C) París
  ),

  // Segunda pregunta sobre el río más largo del mundo.
  Question(
    "¿Cuál es el río más largo del mundo?",
    [
      "A) Amazonas",
      "B) Nilo",
      "C) Yangtsé",
      "D) Misisipi"
    ], // Opciones de respuesta
    1, // Índice de la respuesta correcta (B) Nilo
  ),

  // Tercera pregunta sobre el autor de 'Cien años de soledad'.
  Question(
    "¿Quién escribió 'Cien años de soledad'?",
    [
      "A) Julio Cortázar",
      "B) Gabriel García Márquez", // Respuesta correcta
      "C) Mario Vargas Llosa",
      "D) Isabel Allende"
    ],
    1, // Índice de la respuesta correcta (B) Gabriel García Márquez
  ),

  // Cuarta pregunta sobre el continente más grande.
  Question(
    "¿Cuál es el continente más grande?",
    [
      "A) África",
      "B) América",
      "C) Asia",
      "D) Europa"
    ], // Opciones de respuesta
    2, // Índice de la respuesta correcta (C) Asia
  ),
];
