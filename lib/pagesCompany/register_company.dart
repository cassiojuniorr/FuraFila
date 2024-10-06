import 'package:flutter/material.dart';
import 'package:fura_fila/helpers/RegisterHelpers.dart';
import 'package:fura_fila/pagesCustomer/login_customer.dart';
import '../style/form_style.dart';

class RegisterCompany extends StatefulWidget {
  const RegisterCompany({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterCompany();
}

class _RegisterCompany extends State<RegisterCompany> {
  bool? _termos = false;
  bool? _companyregister = false;

  final TextEditingController _nameCompanyController = TextEditingController();
  final TextEditingController _emailCompanyController = TextEditingController();
  final TextEditingController _passwordCompanyController =
      TextEditingController();
  final TextEditingController _passwordConfirmCompanyController =
      TextEditingController();
  final TextEditingController _cnpjCompanyController = TextEditingController();
  final TextEditingController _cepCompanyController = TextEditingController();
  final TextEditingController _filiaisCompanyController =
      TextEditingController();
  final TextEditingController _queueCompanyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameCompanyController.addListener(_updateState);
    _emailCompanyController.addListener(_updateState);
    _passwordCompanyController.addListener(_updateState);
    _passwordConfirmCompanyController.addListener(_updateState);
    _cnpjCompanyController.addListener(_updateState);
    _cepCompanyController.addListener(_updateState);
    _filiaisCompanyController.addListener(_updateState);
    _queueCompanyController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {});
  }

  @override
  void dispose() {
    _nameCompanyController.removeListener(_updateState);
    _emailCompanyController.removeListener(_updateState);
    _passwordCompanyController.removeListener(_updateState);
    _passwordConfirmCompanyController.removeListener(_updateState);
    _cnpjCompanyController.removeListener(_updateState);
    _cepCompanyController.removeListener(_updateState);
    _filiaisCompanyController.removeListener(_updateState);
    _queueCompanyController.removeListener(_updateState);

    _nameCompanyController.dispose();
    _emailCompanyController.dispose();
    _passwordCompanyController.dispose();
    _passwordConfirmCompanyController.dispose();
    _cnpjCompanyController.dispose();
    _cepCompanyController.dispose();
    _filiaisCompanyController.dispose();
    _queueCompanyController.dispose();
    _companyregister = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    FormStyle _formStyle = FormStyle();
    RegisterHelpersCompany _registerHelpersCompany = RegisterHelpersCompany();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(46, 10, 96, 1),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, right: 40, left: 40),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 6.0,
                    runSpacing: 10.0,
                    children: [
                      const Text(
                        'Deseja se cadastrar como usuário?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Checkbox(
                        value: _companyregister,
                        activeColor: const Color.fromRGBO(109, 68, 160, 1),
                        onChanged: (newBool) {
                          setState(() {
                            _companyregister = newBool!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50, left: 50),
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 1,
                      controller: _nameCompanyController,
                      decoration: _formStyle.fieldStyleLabel('Nome da empresa'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50, left: 50),
                    child: TextFormField(
                      controller: _emailCompanyController,
                      decoration:
                          _formStyle.fieldStyleLabel('Digite seu e-mail'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50, left: 50),
                    child: TextFormField(
                      controller: _passwordCompanyController,
                      decoration: _formStyle.fieldStyleLabel('Digite a senha'),
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50, left: 50),
                    child: TextFormField(
                      controller: _passwordConfirmCompanyController,
                      decoration: _formStyle.fieldStyleLabel('Confirme senha'),
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50, left: 50),
                    child: TextFormField(
                      controller: _cepCompanyController,
                      decoration: _formStyle.fieldStyleLabel('Cep'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50, left: 50),
                    child: TextFormField(
                      controller: _cnpjCompanyController,
                      decoration: _formStyle.fieldStyleLabel('CNPJ'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50, left: 50),
                    child: TextFormField(
                      controller: _queueCompanyController,
                      decoration: _formStyle.fieldStyleLabel(
                          'Preferência de atendimento online (1-10)'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50, left: 50),
                    child: TextFormField(
                      controller: _filiaisCompanyController,
                      decoration:
                          _formStyle.fieldStyleLabel('Número de filiais'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 6.0,
                    runSpacing: 10.0,
                    children: [
                      Checkbox(
                        value: _termos,
                        activeColor: const Color.fromRGBO(109, 68, 160, 1),
                        onChanged: (newBool) {
                          setState(() {
                            _termos = newBool!;
                          });
                        },
                      ),
                      const Text(
                        'Aceitar termos de licença',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      _registerHelpersCompany.validFormCompany(
                              _nameCompanyController.text,
                              _emailCompanyController.text,
                              _passwordCompanyController.text,
                              _passwordConfirmCompanyController.text,
                              _cnpjCompanyController.text,
                              _cepCompanyController.text,
                              _filiaisCompanyController.text,
                              _queueCompanyController.text,
                              _termos,
                              context)
                          ? await _registerHelpersCompany.registerCompany(
                              _nameCompanyController.text,
                              _emailCompanyController.text,
                              _passwordCompanyController.text,
                              _passwordConfirmCompanyController.text,
                              _cnpjCompanyController.text,
                              _cepCompanyController.text,
                              _filiaisCompanyController.text,
                              _queueCompanyController.text,
                              context)
                          : null;
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        const Color.fromRGBO(151, 106, 202, 1),
                      ),
                    ),
                    child: const Text(
                      'Cadastrar',
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
                  const SizedBox(
                    height: 40,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
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
        ],
      ),
    );
  }
}
