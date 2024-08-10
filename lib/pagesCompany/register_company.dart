import 'package:flutter/material.dart';
import '../style/form_style.dart';
import 'package:fura_fila/services/auth_service.dart';

class RegisterCompany extends StatefulWidget {
  const RegisterCompany({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterCompany();
}

class _RegisterCompany extends State<RegisterCompany> {
  // final _formKey = GlobalKey<FormState>();
  bool? _termos = false;
  bool? _companyregister = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final AuthService _authService = AuthService();
    FormStyle _formStyle = FormStyle();
    final TextEditingController _nameCompanyController =
        TextEditingController();
    final TextEditingController _emailCompanyController =
        TextEditingController();
    final TextEditingController _passwordCompanyController =
        TextEditingController();

    singUpButton() {
      _authService.singUser(
          name: _nameCompanyController.text,
          password: _passwordCompanyController.text,
          email: _emailCompanyController.text);
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(46, 10, 96, 1),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, right: 40, left: 40),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 10, left: 6),
                        child: Text(
                          'Deseja se cadastrar como usuario??',
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
                          activeColor: const Color.fromRGBO(109, 68, 160, 1),
                          onChanged: (newBool) {
                            setState(() {
                              _companyregister = newBool!;
                            });
                            Navigator.pop(context);
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
                      controller: _nameCompanyController,
                      decoration:
                          _formStyle.fieldStyle('Digite o da sua empresa'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50, left: 50),
                    child: TextFormField(
                      controller: _emailCompanyController,
                      decoration: _formStyle.fieldStyle('Digite seu e-mail'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50, left: 50),
                    child: TextFormField(
                      controller: _passwordCompanyController,
                      decoration: _formStyle.fieldStyle('Digite a senha'),
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
                  Padding(
                    padding: const EdgeInsets.only(right: 50, left: 50),
                    child: TextFormField(
                      decoration: _formStyle.fieldStyle('Cep'),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50, left: 50),
                    child: TextFormField(
                      decoration: _formStyle.fieldStyle('Cnpj'),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50, left: 50),
                    child: TextFormField(
                      decoration: _formStyle.fieldStyle(
                          'Preferência de atendimento online (1-10)'),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50, left: 50),
                    child: TextFormField(
                      decoration: _formStyle.fieldStyle('Número de filiais?'),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                      'Cadastrar Empresa',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        height: 2,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
