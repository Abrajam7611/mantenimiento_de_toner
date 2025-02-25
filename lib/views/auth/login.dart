import 'package:flutter/material.dart';
import 'email_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controladores de texto para los campos de entrada
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController codigoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  // Claves globales para controlar el enfoque de los campos de entrada
  final GlobalKey _nombreKey = GlobalKey();
  final GlobalKey _telefonoKey = GlobalKey();
  final GlobalKey _codigoKey = GlobalKey();

  // Método para manejar el inicio de sesión con código
  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      Future.delayed(Duration(seconds: 2), () {
        setState(() => isLoading = false);
        print("Usuario autenticado");
      });
    }
  }

  // Método para hacer scroll automáticamente a un campo de entrada cuando se enfoca
  void _scrollToField(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Future.delayed(Duration(milliseconds: 300), () {
        Scrollable.ensureVisible(
          context,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determina si la pantalla es lo suficientemente grande para usar el diseño web
    final bool isLargeScreen = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: isLargeScreen ? _buildWebLayout() : _buildMobileLayout(),
    );
  }

  // Diseño para dispositivos móviles
  Widget _buildMobileLayout() {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: SingleChildScrollView(
              controller: _scrollController,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: EdgeInsets.only(bottom: keyboardHeight),
                child: _buildLoginForm(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Diseño para pantallas grandes (Web)
  Widget _buildWebLayout() {
    return Row(
      children: [
        Expanded(flex: 1, child: _buildHeaderWeb()),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: SingleChildScrollView(child: _buildLoginForm()),
          ),
        ),
      ],
    );
  }

  // Formulario de inicio de sesión
  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Recuerda solicitar tu código',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15),
          _buildTextField('Nombre', nombreController, _nombreKey),
          SizedBox(height: 7),
          _buildTextField(
            'Teléfono',
            telefonoController,
            _telefonoKey,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Ingrese su teléfono';
              if (value.length < 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                return 'Número no válido';
              }
              return null;
            },
          ),
          SizedBox(height: 7),
          _buildTextField('Código', codigoController, _codigoKey),
          SizedBox(height: 20),
          _buildLoginButton(),
          SizedBox(height: 15),
          _buildEmailLoginButton(),
        ],
      ),
    );
  }

  // Encabezado del diseño móvil
  Widget _buildHeader() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.50,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(child: CustomPaint(painter: BackgroundPainter())),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/login.png', width: 130, height: 130),
              SizedBox(height: 5),
              Text(
                'Mantenimiento y Gestión de Tóner',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Text(
                'Optimiza tu impresión, gestiona tu tóner con precisión',
                style: TextStyle(fontSize: 14, color: Colors.greenAccent),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Encabezado del diseño web
  Widget _buildHeaderWeb() {
    return Container(
      color: Color(0xFF68377A),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/login.png', width: 130, height: 130),
            SizedBox(height: 5),
            Text(
              'Mantenimiento y Gestión de Tóner',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Optimiza tu impresión, gestiona tu tóner con precisión',
              style: TextStyle(fontSize: 16, color: Colors.greenAccent),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Widget reutilizable para los campos de entrada
  Widget _buildTextField(
    String label,
    TextEditingController controller,
    GlobalKey key, {
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus) _scrollToField(key);
      },
      child: TextFormField(
        key: key,
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Color(0xFFF0D4FA),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Botón para iniciar sesión
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF68377A),
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
        ),
        child:
            isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : Text(
                  'Ingresar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
      ),
    );
  }

  // Botón para iniciar sesión
  Widget _buildEmailLoginButton() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EmailLoginScreen()),
        );
      },
      child: Text(
        'Ingresar con Correo Electrónico',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Pintor personalizado para el fondo
class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xFF68377A);
    Path path = Path()..lineTo(0, size.height * 0.85);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.75,
      size.width * 0.5,
      size.height * 0.85,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.95,
      size.width,
      size.height * 0.85,
    );
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
