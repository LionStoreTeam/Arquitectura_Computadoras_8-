import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:registro_articulos/nuevos_articulos/registros_guardados.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class NuevoRegistroArticulo extends StatefulWidget {
  const NuevoRegistroArticulo({super.key});

  @override
  State<NuevoRegistroArticulo> createState() => _NuevoRegistroArticuloState();
}

class _NuevoRegistroArticuloState extends State<NuevoRegistroArticulo> {
  double rating = 0.0;

  void updateRating(double value) {
    setState(() {
      rating = value;
    });
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _openCamara() async {
    final XFile? imagen = await _picker.pickImage(source: ImageSource.camera);
    if (imagen != null) {
      // print('Imagen seleccionada: ${imagen.path}');
    }
  }

  void _showToast(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Artículo guardado",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // Redirigir después de mostrar el Toast
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
        title: const Text(
          "Nuevo Artículo",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.pink.shade600,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: Colors.white,
              ),
              onPressed: () => _onBackButtonPressed(context),
            );
          },
        ),
        // actions: [
        //   Builder(
        //     builder: (context) => IconButton(
        //       icon: const Icon(
        //         Icons.arrow_back_ios_rounded,
        //         color: Colors.white,
        //       ),
        //       // onPressed: () => Navigator.of(context).pop(),
        //       onPressed: () {},
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => _openCamara(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            color: Colors.pink.shade700,
                            width: 2,
                          )),
                      child: SizedBox(
                        height: 110,
                        width: 120,
                        // width: MediaQuery.of(context).size.width,
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 100,
                          color: Colors.pink.shade900,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Nombre del Artículo",
                          suffixIcon: const Icon(Icons.assignment_outlined),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.pink.shade100, width: 3),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.pink.shade700, width: 3),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.auto_fix_high_sharp),
                          labelText: "Alias",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.pink.shade100, width: 3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.pink.shade700, width: 3),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "Descripción",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      TextField(
                        autofocus: false,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.pink.shade700,
                              width: 3,
                            ),
                          ),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.pinkAccent,
                            ),
                          ),
                          hintText: 'Añade una descripción',
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text('Puntuación: $rating',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      PannableRatingBar(
                        rate: rating,
                        items: List.generate(
                            5,
                            (index) => const RatingWidget(
                                  selectedColor: Colors.yellow,
                                  unSelectedColor: Colors.grey,
                                  child: Icon(
                                    Icons.star,
                                    size: 48,
                                  ),
                                )),
                        onChanged: (value) {
                          // El valor del rating cambia al ser presionado
                          setState(() {
                            rating = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              // Change your radius here
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          padding: const WidgetStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 5)),
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.pink.shade400),
                        ),
                        onPressed: () => _showToast(context),
                        icon: const Icon(
                          Icons.save,
                          color: Colors.white,
                          size: 30,
                        ),
                        label: const Text(
                          "Guardar",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método para mostrar un AlertDialog para salir de la aplicación
  Future<bool> _onBackButtonPressed(BuildContext context) async {
    bool exitApp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Salir de la aplicación"),
          content: const Text("¿Quieres salir de la aplicación?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () =>
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
              child: const Text("Si"),
            ),
          ],
        );
      },
    );
    return exitApp;
  }
}
