import 'package:flutter/material.dart'; // Importa los componentes básicos de Flutter.
import 'package:flutter/services.dart'; // Para manejar interacciones del sistema.
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart'; // Para el RatingBar personalizable.
import 'package:registro_articulos/nuevos_articulos/registros_guardados.dart'; // Importa la pantalla de registros guardados.
import 'package:fluttertoast/fluttertoast.dart'; // Para mostrar mensajes breves.
import 'package:image_picker/image_picker.dart'; // Para seleccionar imágenes de la cámara o galería.
import 'package:shared_preferences/shared_preferences.dart'; // Para persistencia de datos.

class NuevoRegistroArticulo extends StatefulWidget {
  const NuevoRegistroArticulo({super.key}); // Constructor del widget.

  @override
  State<NuevoRegistroArticulo> createState() =>
      _NuevoRegistroArticuloState(); // Crea el estado asociado al widget.
}

class _NuevoRegistroArticuloState extends State<NuevoRegistroArticulo> {
  double rating = 0.0; // Inicializa el rating en 0.
  String articuloNombre = ''; // Almacena el nombre del artículo.
  String articuloAlias = ''; // Almacena el alias del artículo.
  String descripcion = ''; // Almacena la descripción del artículo.
  String imagenPath = ''; // Almacena la ruta de la imagen seleccionada.

  // Controladores de texto para los campos de entrada.
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController aliasController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  final ImagePicker _picker =
      ImagePicker(); // Inicializa el ImagePicker para tomar fotos.

  // Método para abrir la cámara y seleccionar una imagen.
  Future<void> _openCamara() async {
    final XFile? imagen = await _picker.pickImage(source: ImageSource.camera);
    if (imagen != null) {
      setState(() {
        imagenPath = imagen.path; // Guarda la ruta de la imagen seleccionada.
      });
    }
  }

  // Método para guardar los datos en SharedPreferences.
  Future<void> _guardarDatos() async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Obtiene una instancia de SharedPreferences.
    await prefs.setString('nombre', nombreController.text); // Guarda el nombre.
    await prefs.setString('alias', aliasController.text); // Guarda el alias.
    await prefs.setString(
        'descripcion', descripcionController.text); // Guarda la descripción.
    await prefs.setString('imagen', imagenPath); // Guarda la ruta de la imagen.
    await prefs.setDouble('rating', rating); // Guarda la puntuación.
  }

  // Método para mostrar un mensaje de éxito al guardar los datos.
  void _showToast(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Artículo guardado", // Mensaje que se mostrará.
      toastLength: Toast.LENGTH_SHORT, // Duración del mensaje.
      gravity: ToastGravity.BOTTOM, // Posición en la pantalla.
      timeInSecForIosWeb: 1, // Tiempo de visualización en iOS.
      backgroundColor: Colors.black, // Color de fondo del mensaje.
      textColor: Colors.white, // Color del texto.
      fontSize: 16.0, // Tamaño de fuente.
    );

    // Redirige a la pantalla de registros guardados después de un breve retraso.
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const RegistrosArticulosGuardados()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo Artículo",
            style: TextStyle(color: Colors.white)), // Título de la appBar.
        centerTitle: true, // Centra el título.
        elevation: 0, // Sin sombra.
        backgroundColor: Colors.pink.shade600, // Color de fondo de la appBar.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp,
              color: Colors.white), // Icono de retroceso.
          onPressed: () => _onBackButtonPressed(
              context), // Método para manejar el botón de retroceso.
        ),
      ),
      body: SingleChildScrollView(
        // Permite hacer scroll en caso de que el contenido sea largo.
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0), // Padding para el contenido.
            child: Column(
              children: [
                GestureDetector(
                  // Detecta gestos, en este caso, el toque.
                  onTap: () =>
                      _openCamara(), // Abre la cámara al tocar el contenedor.
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(5)), // Bordes redondeados.
                      border: Border.all(
                          color: Colors.pink.shade700,
                          width: 2), // Borde del contenedor.
                    ),
                    child: SizedBox(
                      height: 110, // Altura del contenedor.
                      width: 120, // Anchura del contenedor.
                      child: Icon(Icons.camera_alt_outlined,
                          size: 100,
                          color: Colors.pink.shade900), // Icono de la cámara.
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Espaciado vertical.
                Padding(
                  padding: const EdgeInsets.all(8.0), // Padding interno.
                  child: Column(
                    children: [
                      const SizedBox(height: 20), // Espaciado vertical.
                      TextField(
                        controller:
                            nombreController, // Controlador para el campo de texto.
                        decoration: InputDecoration(
                          labelText:
                              "Nombre del Artículo", // Texto de la etiqueta.
                          suffixIcon: const Icon(Icons
                              .assignment_outlined), // Icono al final del campo.
                          enabledBorder: OutlineInputBorder(
                            // Estilo del borde cuando está habilitado.
                            borderSide: BorderSide(
                                color: Colors.pink.shade100, width: 3),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            // Estilo del borde cuando está enfocado.
                            borderSide: BorderSide(
                                color: Colors.pink.shade700, width: 3),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20), // Espaciado vertical.
                      TextField(
                        controller:
                            aliasController, // Controlador para el campo de texto.
                        decoration: InputDecoration(
                          labelText: "Alias", // Texto de la etiqueta.
                          suffixIcon: const Icon(Icons
                              .auto_fix_high_sharp), // Icono al final del campo.
                          enabledBorder: OutlineInputBorder(
                            // Estilo del borde cuando está habilitado.
                            borderSide: BorderSide(
                                color: Colors.pink.shade100, width: 3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            // Estilo del borde cuando está enfocado.
                            borderSide: BorderSide(
                                color: Colors.pink.shade700, width: 3),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20), // Espaciado vertical.
                      TextField(
                        controller:
                            descripcionController, // Controlador para el campo de texto.
                        decoration: InputDecoration(
                          hintText:
                              'Añade una descripción', // Texto que aparece cuando el campo está vacío.
                          focusedBorder: UnderlineInputBorder(
                            // Estilo del borde cuando está enfocado.
                            borderSide: BorderSide(
                                color: Colors.pink.shade700, width: 3),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20), // Espaciado vertical.
                      Text('Puntuación: $rating',
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight:
                                  FontWeight.bold)), // Muestra la puntuación.
                      const SizedBox(height: 20), // Espaciado vertical.
                      PannableRatingBar(
                        rate: rating, // Asigna el rating actual.
                        items: List.generate(
                          5, // Crea 5 estrellas.
                          (index) => const RatingWidget(
                            selectedColor: Colors
                                .yellow, // Color de las estrellas seleccionadas.
                            unSelectedColor: Colors
                                .grey, // Color de las estrellas no seleccionadas.
                            child: Icon(Icons.star,
                                size: 48), // Icono de estrella.
                          ),
                        ),
                        onChanged: (value) {
                          // Método que se llama cuando cambia el rating.
                          setState(() {
                            rating = value; // Actualiza el rating.
                          });
                        },
                      ),
                      const SizedBox(height: 20), // Espaciado vertical.
                      ElevatedButton.icon(
                        // Botón para guardar los datos.
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5))), // Estilo del botón.
                          padding: const WidgetStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 5)), // Padding del botón.
                          backgroundColor: WidgetStatePropertyAll(Colors
                              .pink.shade400), // Color de fondo del botón.
                        ),
                        onPressed: () async {
                          await _guardarDatos(); // Llama al método para guardar los datos.
                          // ignore: use_build_context_synchronously
                          _showToast(context); // Muestra el mensaje de éxito.
                        },
                        icon: const Icon(Icons.save,
                            color: Colors.white, size: 30), // Icono del botón.
                        label: const Text("Guardar",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30)), // Texto del botón.
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método que se ejecuta al presionar el botón de retroceso.
  Future<bool> _onBackButtonPressed(BuildContext context) async {
    bool exitApp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Salir de la aplicación"), // Título del diálogo.
          content: const Text(
              "¿Quieres salir de la aplicación?"), // Mensaje del diálogo.
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context)
                    .pop(false), // Cierra el diálogo sin salir.
                child: const Text("No")),
            TextButton(
                onPressed: () => SystemChannels.platform.invokeMethod(
                    'SystemNavigator.pop'), // Cierra la aplicación.
                child: const Text("Si")),
          ],
        );
      },
    );
    return exitApp; // Devuelve el resultado de la decisión del usuario.
  }
}
