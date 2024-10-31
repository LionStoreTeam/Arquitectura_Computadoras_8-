import 'package:flutter/material.dart'; // Importa los componentes básicos de Flutter.
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart'; // Importa el RatingBar personalizable.
import 'package:shared_preferences/shared_preferences.dart'; // Importa la librería para almacenamiento persistente.
import 'dart:io'; // Importa la biblioteca para manejar archivos.

class RegistrosArticulosGuardados extends StatefulWidget {
  const RegistrosArticulosGuardados({super.key}); // Constructor del widget.

  @override
  State<RegistrosArticulosGuardados> createState() =>
      _RegistrosArticulosGuardadosState(); // Crea el estado asociado al widget.
}

class _RegistrosArticulosGuardadosState
    extends State<RegistrosArticulosGuardados> {
  String nombre = ''; // Almacena el nombre del artículo.
  String alias = ''; // Almacena el alias del artículo.
  String descripcion = ''; // Almacena la descripción del artículo.
  String imagenPath = ''; // Almacena la ruta de la imagen.
  double rating = 0.0; // Almacena la puntuación del artículo.

  @override
  void initState() {
    super.initState(); // Llama al método initState de la clase base.
    _cargarDatos(); // Llama al método para cargar los datos.
  }

  // Método para cargar los datos guardados en SharedPreferences.
  Future<void> _cargarDatos() async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Obtiene una instancia de SharedPreferences.
    setState(() {
      nombre = prefs.getString('nombre') ??
          ''; // Carga el nombre o asigna una cadena vacía.
      alias = prefs.getString('alias') ??
          ''; // Carga el alias o asigna una cadena vacía.
      descripcion = prefs.getString('descripcion') ??
          ''; // Carga la descripción o asigna una cadena vacía.
      imagenPath = prefs.getString('imagen') ??
          ''; // Carga la ruta de la imagen o asigna una cadena vacía.
      rating =
          prefs.getDouble('rating') ?? 0.0; // Carga la puntuación o asigna 0.0.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Artículos Guardados", // Título de la appBar.
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true, // Centra el título en la appBar.
        elevation: 0, // Sin sombra en la appBar.
        backgroundColor: Colors.pink.shade600, // Color de fondo de la appBar.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp,
              color: Colors.white), // Icono de retroceso.
          onPressed: () =>
              Navigator.of(context).pop(), // Regresa a la pantalla anterior.
        ),
      ),
      body: SingleChildScrollView(
        // Permite hacer scroll en caso de que el contenido sea largo.
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Muestra la imagen si la ruta no está vacía.
              if (imagenPath.isNotEmpty)
                Container(
                  height: 200, // Altura del contenedor de la imagen.
                  width: MediaQuery.of(context)
                      .size
                      .width, // Anchura igual al ancho de la pantalla.
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                          File(imagenPath)), // Carga la imagen desde la ruta.
                      fit: BoxFit.cover, // Ajusta la imagen al contenedor.
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20), // Padding horizontal para el texto.
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Muestra el nombre del artículo.
                    Text(
                      'Nombre: $nombre',
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20), // Espaciado vertical.
                    // Muestra el alias del artículo.
                    Text(
                      'Alías: $alias',
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20), // Espaciado vertical.
                    // Muestra la descripción del artículo.
                    Text(
                      'Descripción: $descripcion',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40), // Espaciado vertical.
              Center(
                child: Column(
                  children: [
                    // Muestra la puntuación.
                    Text('Puntuación: $rating',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10), // Espaciado vertical.
                    // Muestra el RatingBar para la puntuación.
                    PannableRatingBar(
                      rate: rating, // Asigna el rating actual.
                      items: List.generate(
                        5, // Crea 5 estrellas.
                        (index) => const RatingWidget(
                          selectedColor: Colors
                              .yellow, // Color de las estrellas seleccionadas.
                          unSelectedColor: Colors
                              .grey, // Color de las estrellas no seleccionadas.
                          child: Icon(
                            Icons.star,
                            size: 48, // Tamaño de la estrella.
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        // Se llama cuando cambia la puntuación.
                        setState(() {
                          rating = value; // Actualiza el rating.
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
