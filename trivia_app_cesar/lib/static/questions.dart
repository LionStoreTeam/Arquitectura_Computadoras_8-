class Question {
  final String question;
  final List<String> answers;
  final int correctAnswerIndex;

  Question(this.question, this.answers, this.correctAnswerIndex);
}

final List<Question> questions = [
  Question(
    "¿Cuál es la capital de Francia?",
    ["A) Berlín", "B) Madrid", "C) París", "D) Lisboa"],
    2,
  ),
  Question(
    "¿Cuál es el río más largo del mundo?",
    ["A) Amazonas", "B) Nilo", "C) Yangtsé", "D) Misisipi"],
    1,
  ),
  Question(
    "¿Quién escribió 'Cien años de soledad'?",
    [
      "A) Julio Cortázar",
      "B) Gabriel García Márquez",
      "C) Mario Vargas Llosa",
      "D) Isabel Allende"
    ],
    1,
  ),
  Question(
    "¿Cuál es el continente más grande?",
    ["A) África", "B) América", "C) Asia", "D) Europa"],
    2,
  ),
];
