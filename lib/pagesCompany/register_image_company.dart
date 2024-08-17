import 'package:flutter/material.dart';
import 'package:fura_fila/style/form_style.dart';

class RegisterImageCompany extends StatefulWidget {
  const RegisterImageCompany({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterImageCompany();
}

class _RegisterImageCompany extends State<RegisterImageCompany> {

  @override
  Widget build(BuildContext context) {
  FormStyle _formStyle = FormStyle();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(46, 10, 96, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, right: 40, left: 40),
        child: Expanded(
          child: Form(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50, left: 50),
                        child: TextFormField(
                          //controller: _emailLoginController,
                          decoration:
                              _formStyle.fieldStyle('Digite seu e-mail'),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
