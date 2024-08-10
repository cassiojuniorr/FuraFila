import 'package:flutter/material.dart';
import '../style/form_style.dart';
import 'package:fura_fila/pagesCompany/register_company.dart';
import 'package:fura_fila/services/auth_service.dart';
// import '../core/snack_bar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  // final _formKey = GlobalKey<FormState>();
  bool? _termos = false;
  bool? _companyregister = false;

  changeUserCompany(newBool) {
    setState(() {
      _companyregister = newBool!;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterCompany()),
    );
    setState(() {
      _companyregister = !newBool;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final AuthService _authService = AuthService();
    FormStyle _formStyle = FormStyle();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    singUpButton() {
      _authService.singUser(
          name: _nameController.text,
          password: _passwordController.text,
          email: _emailController.text);

      /* .then((String? erro) {
        if (erro != null) {
          showSnackBar(context: context, text: erro);
        } else {
          showSnackBar(
              context: context,
              text: "Cadastro efetuado com sucesso!",
              isErro: false);
        }
      }) */
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
                        "../../assets/logo.png",
                        height: screenSize.width * 0.2,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 10, left: 6),
                            child: Text(
                              'Deseja se cadastrar como empresa??',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Checkbox(
                              value: _companyregister,
                              activeColor:
                                  const Color.fromRGBO(109, 68, 160, 1),
                              onChanged: (newBool) {
                                changeUserCompany(newBool);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50, left: 50),
                        child: TextFormField(
                          minLines: 1,
                          maxLines: 1,
                          controller: _nameController,
                          decoration: _formStyle.fieldStyle('Digite seu nome'),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50, left: 50),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: _formStyle.fieldStyle('Digite seu e-mail'),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50, left: 50),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: _formStyle.fieldStyle('Digite sua senha'),
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50, left: 50),
                        child: TextFormField(
                          decoration: _formStyle.fieldStyle('Confirme senha'),
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: Checkbox(
                              value: _termos,
                              activeColor:
                                  const Color.fromRGBO(109, 68, 160, 1),
                              onChanged: (newBool) {
                                setState(() {
                                  _termos = newBool!;
                                });
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 50, left: 6),
                            child: Text(
                              'Aceitar termos de licença',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          singUpButton();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(151, 106, 202, 1),
                          ),
                        ),
                        child: const Text(
                          'Cadastrar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            height: 2,
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
                        height: 50,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Já possui uma conta? Entrar',
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
