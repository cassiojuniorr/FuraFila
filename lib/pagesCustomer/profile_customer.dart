import 'package:flutter/material.dart';
import 'package:fura_fila/pagesCustomer/home_customer.dart';
import 'package:fura_fila/pagesCustomer/login_customer.dart';
import 'package:fura_fila/services/auth_service.dart';

class ProfileCustomer extends StatefulWidget {
  const ProfileCustomer({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileCustomer();
}

class _ProfileCustomer extends State<ProfileCustomer> {
  int _currentIndex = 0;
  final AuthService _authService = AuthService();
  final TextEditingController _namePerfilController = TextEditingController();
  final TextEditingController _emailPerfilController = TextEditingController();
  final TextEditingController _passwordPerfilController =
      TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();

  InputDecoration fieldStyleProfile(text) {
    return InputDecoration(
      border: const UnderlineInputBorder(),
      labelText: text,
      filled: true,
      fillColor: Colors.white,
      prefixIcon: Image.asset(
        "assets/fountain-pen-tip.png",
        height: 0.5,
        width: 0.5,
        color: const Color.fromRGBO(46, 10, 96, 1),
      ),
      labelStyle: const TextStyle(
        color: Color.fromRGBO(166, 166, 166, 1),
        fontSize: 16,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  void _onItemTapped(int index) async {
    if (index == 1) {
      await _authService.signOut(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
                child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          print("Imagem clicada!");
                        },
                        child: Image.asset(
                          "assets/pictureDefaultGrad.png",
                          height: screenSize.width * 0.2,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50, left: 50),
                      child: TextFormField(
                        controller: _namePerfilController,
                        decoration: fieldStyleProfile('Editar seu nome'),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50, left: 50),
                      child: TextFormField(
                        controller: _emailPerfilController,
                        decoration: fieldStyleProfile('Editar seu e-mail'),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50, left: 50),
                      child: TextFormField(
                        controller: _passwordPerfilController,
                        decoration: fieldStyleProfile('Mudar sua senha'),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50, left: 50),
                      child: TextFormField(
                        obscureText: true,
                        controller: _currentPasswordController,
                        decoration: fieldStyleProfile('Senha atual'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await _authService.updateProfileUser(
                            _namePerfilController.text,
                            _emailPerfilController.text,
                            _passwordPerfilController.text,
                            _currentPasswordController.text,
                            context);

                        _namePerfilController.clear();
                        _emailPerfilController.clear();
                        _passwordPerfilController.clear();
                        _currentPasswordController.clear();
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          const Color.fromRGBO(46, 10, 96, 1),
                        ),
                      ),
                      child: const Text(
                        'Salvar',
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
                      height: 20,
                    ),
                  ],
                ),
              ),
            )),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color.fromRGBO(46, 10, 96, 1),
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            label: 'P R I N C I P A L',
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: 'D E S L O G A R',
            icon: Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
