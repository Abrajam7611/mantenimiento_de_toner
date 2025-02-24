import 'package:flutter/material.dart';
import 'forgot_password.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  _EmailLoginScreenState createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  // Controladores de texto para los campos de entrada
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  // Claves globales para controlar el enfoque de los campos de entrada
  final GlobalKey _emailKey = GlobalKey();
  final GlobalKey _passwordKey = GlobalKey();

  // Método para manejar el inicio de sesión con email
  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      Future.delayed(Duration(seconds: 2), () {
        setState(() => isLoading = false);
        print("Usuario autenticado con correo");
      });
    }
  }

  // Método para hacer scroll automáticamente a un campo de entrada cuando se enfoca
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
    // Determina si la pantalla es lo suficientemente grande para usar el diseño web
    final bool isLargeScreen = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: isLargeScreen ? _buildWebLayout() : _buildMobileLayout(),
    );
  }

  // Diseño para dispositivos móviles
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

  // Diseño para pantallas grandes (Web)
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

  // Formulario de inicio de sesión
  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Ingresa con tu cuenta',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15),
          _buildTextField('Correo Electrónico', emailController, _emailKey, validator: (value) {
            if (value == null || value.isEmpty) return 'Ingrese su correo';
            if (!value.contains('@')) return 'Correo no válido';
            return null;
          }),
          SizedBox(height: 7),
          _buildTextField('Contraseña', passwordController, _passwordKey, isPassword: true, validator: (value) {
            if (value == null || value.isEmpty) return 'Ingrese su contraseña';
            return null;
          }),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                );
              },
              child: Text('¿Olvidaste la contraseña?', style: TextStyle(color: Colors.black)),
            ),
          ),
          SizedBox(height: 20),
          _buildLoginButton(),
          SizedBox(height: 15),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Ingresar con Código de acceso',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Encabezado del diseño móvil
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
                'Mantenimiento y Gestión de Tóner',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Text(
                'Optimiza tu impresión, gestiona tu tóner con precisión',
                style: TextStyle(fontSize: 14, color: Colors.greenAccent),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Encabezado del diseño web
  Widget _buildHeaderWeb() {
    return Container(
      color: Color(0xFF68377A),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/login.png',
              width: 130, 
              height: 130,
            ),
            SizedBox(height: 5),
            Text(
              'Mantenimiento y Gestión de Tóner',
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
                color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Optimiza tu impresión, gestiona tu tóner con precisión',
              style: TextStyle(
                fontSize: 16, 
                color: Colors.greenAccent,
              ),
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
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus) _scrollToField(key);
      },
      child: TextFormField(
        key: key,
        controller: controller,
        obscureText: isPassword,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Color(0xFFF0D4FA),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  // Botón para iniciar sesión 
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF68377A),
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
        ),
        child: isLoading
            ? CircularProgressIndicator(color: Colors.white)
            : Text('Ingresar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
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
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.75, size.width * 0.5, size.height * 0.85);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.95, size.width, size.height * 0.85);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}