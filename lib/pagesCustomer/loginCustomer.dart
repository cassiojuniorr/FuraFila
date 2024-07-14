import 'package:flutter/material.dart';
import 'package:fura_fila/services/auth_service.dart';
import 'homeCustomer.dart';
import 'registerCustomer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  // final _formKey = GlobalKey<FormState>();
  InputDecoration fieldStyle(text) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      filled: true,
      fillColor: Colors.white,
      hintText: text,
      hintStyle: const TextStyle(
        color: Color.fromRGBO(166, 166, 166, 1),
        fontSize: 16,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final AuthService _authService = AuthService();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    loginButton() {
      _authService.loginUser(
          email: _emailController.text, password: _passwordController.text);
      if (_authService.getIdUser() != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(46, 10, 96, 1),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(46, 10, 96, 1),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/slogan.png",
                        height: screenSize.width * 0.3,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50, left: 50),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: fieldStyle('Digite seu e-mail'),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50, left: 50),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: fieldStyle('Digite sua senha'),
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Esqueceu sua senha? Recuperar!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          loginButton();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(151, 106, 202, 1),
                          ),
                        ),
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1, 4),
                                blurRadius: 0.5,
                                color: Color.fromRGBO(109, 68, 160, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()),
                          );
                        },
                        child: const Text(
                          'Não tem uma conta? Cadastre-se!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
