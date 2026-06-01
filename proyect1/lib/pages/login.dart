import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

// REVISIÓN DE RUTA: Sube un nivel para encontrar 'firebase_options.dart'
import '../firebase_options.dart'; 

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controladores para capturar el texto de los inputs
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Método para iniciar sesión con Correo y Contraseña en Firebase
  Future<void> _signInWithEmail() async {
    if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
      _showSnackBar('Por favor, llena todos los campos');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      
      // Si el login es correcto, redirige al Home ('/')
      if (mounted) Navigator.pushReplacementNamed(context, '/');
    } on FirebaseAuthException catch (e) {
      String mensajeError = 'Ocurrió un error al iniciar sesión';
      if (e.code == 'user-not-found') mensajeError = 'No existe ningún usuario con este correo';
      if (e.code == 'wrong-password') mensajeError = 'Contraseña incorrecta';
      if (e.code == 'invalid-email') mensajeError = 'El formato del correo no es válido';
      
      _showSnackBar(mensajeError);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Nuevo método: Iniciar sesión con Google (Optimizado para Web)
  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      // Creamos la instancia del proveedor de Google
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      // En la Web, la forma más cómoda y compatible es usar un "Popup" emergente
      await FirebaseAuth.instance.signInWithPopup(googleProvider);

      // Si todo sale bien, mandamos al usuario al Home ('/')
      if (mounted) Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      _showSnackBar('Error al conectar con Google: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje), 
        backgroundColor: const Color(0xFF6E8A78),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Paleta cromática Satori
    const colorFondo = Color(0xFFF1F3F0);
    const colorVerdeHeader = Color(0xFFC2D0C6);
    const colorTextoOscuro = Color(0xFF3E4A41);

    return Scaffold(
      backgroundColor: colorFondo,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Encabezado SATORI
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: colorVerdeHeader,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Center(
                    child: Text(
                      'SATORI',
                      style: GoogleFonts.gideonRoman(
                        textStyle: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: colorTextoOscuro,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                
                Text(
                  'Regresa a tu espacio de calma',
                  style: TextStyle(
                    fontSize: 16,
                    color: colorTextoOscuro.withOpacity(0.8),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 24),

                // Tarjeta del Formulario
                Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        // Input de Email
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Correo electrónico',
                            labelStyle: const TextStyle(color: colorTextoOscuro),
                            filled: true,
                            fillColor: colorFondo,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Input de Password
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            labelStyle: const TextStyle(color: colorTextoOscuro),
                            filled: true,
                            fillColor: colorFondo,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Botón Ingresar
                        _isLoading
                            ? const CircularProgressIndicator(color: colorTextoOscuro)
                            : SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _signInWithEmail,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colorVerdeHeader,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: const Text(
                                    'Iniciar Sesión',
                                    style: TextStyle(
                                      color: colorTextoOscuro,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                        
                        const SizedBox(height: 20),
                        const Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text('o', style: TextStyle(color: Colors.grey)),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Botón de Google
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: // DEBE QUEDAR ASÍ:
                            OutlinedButton.icon(
                              onPressed: _isLoading ? null : _signInWithGoogle, // <-- LLAMA A LA FUNCIÓN AQUÍ
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: colorVerdeHeader, width: 1.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              icon: const Icon(Icons.g_mobiledata, size: 30, color: colorTextoOscuro),
                              label: const Text(
                                'Continuar con Google',
                                style: TextStyle(color: colorTextoOscuro, fontWeight: FontWeight.w600),
                              ),
                            )
                        ),

                        // MODIFICACIÓN: Aquí está tu nuevo enlace hacia el Register
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, 'register');
                          },
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                              children: [
                                TextSpan(text: '¿No tienes cuenta? '),
                                TextSpan(
                                  text: 'Crear cuenta',
                                  style: TextStyle(
                                    color: colorTextoOscuro,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}