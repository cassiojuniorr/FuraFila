import 'package:flutter/material.dart';
import 'package:fura_fila/helpers/LoginHelpers.dart';
import '../style/form_style.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<StatefulWidget> createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  bool? _backLogin = false;

  final TextEditingController _emailCompanyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailCompanyController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {});
  }

  @override
  void dispose() {
    _emailCompanyController.removeListener(_updateState);
    _emailCompanyController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FormStyle _formStyle = FormStyle();
    LoginHelperUser _LoginHelperUser = LoginHelperUser();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(46, 10, 96, 1),
      body: Stack(
        children: [
          Center(
            child: Padding(
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
                          'Voltar para página de Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Checkbox(
                          value: _backLogin,
                          activeColor: const Color.fromRGBO(109, 68, 160, 1),
                          onChanged: (newBool) {
                            setState(() {
                              _backLogin = newBool!;
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
                        controller: _emailCompanyController,
                        decoration:
                            _formStyle.fieldStyleLabel('Digite seu e-mail'),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await _LoginHelperUser.resetPassword(
                            _emailCompanyController.text, context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(151, 106, 202, 1),
                        ),
                      ),
                      child: const Text(
                        'Resetar Senha',
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
