import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
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

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final TextEditingController _emailController = TextEditingController();
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
                    Image.asset(
                      "assets/pictureDefaultGrad.png",
                      height: screenSize.width * 0.2,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50, left: 50),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: fieldStyleProfile('Editar seu nome'),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50, left: 50),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: fieldStyleProfile('Editar seu e-mail'),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50, left: 50),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: fieldStyleProfile('Mudar sua senha'),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(46, 10, 96, 1),
                        ),
                      ),
                      child: const Text(
                        'Salvar Dados',
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
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Cu',
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Penis',                       
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Pau',
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
