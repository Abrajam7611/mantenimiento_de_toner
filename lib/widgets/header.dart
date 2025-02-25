import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;

        return AppBar(
          backgroundColor: const Color.fromARGB(255, 103, 50, 136),
          toolbarHeight: 80, // Ajusta la altura del AppBar
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center, // Centrar texto
                  children: const [
                    Text(
                      "Genera tu reporte",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Área: Cerezo",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 32, // Tamaño del icono
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(4), // Bordes cuadrados
                  ),
                  child: const Center(
                    child: FaIcon(FontAwesomeIcons.user, color: Colors.white, size: 18),
                  ),
                ),
                if (!isMobile) ...[
                  const SizedBox(width: 8),
                  const Text(
                    "Bienvenido\nUsuario",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.bell, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(3.1416), 
                child: const FaIcon(FontAwesomeIcons.rightToBracket, color: Colors.white),
              ),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: const Header(),
      body: const Center(child: Text("Contenido aquí")),
    ),
  ));
}
