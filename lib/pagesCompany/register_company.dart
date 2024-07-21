import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.only(top: 200),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 10, left: 6),
                      child: Text(
                        'Deseha se cadastrar como usuario??',
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
                    decoration: fieldStyle('Digite seu nome da sua empresa'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50, left: 50),
                  child: TextFormField(
                    controller: _emailCompanyController,
                    decoration: fieldStyle('Digite seu e-mail'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50, left: 50),
                  child: TextFormField(
                    controller: _passwordCompanyController,
                    decoration: fieldStyle('Digite a senha'),
                    obscureText: true,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50, left: 50),
                  child: TextFormField(
                    decoration: fieldStyle('Confirme senha'),
                    obscureText: true,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50, left: 50),
                  child: TextFormField(
                    decoration: fieldStyle('Cep'),
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
