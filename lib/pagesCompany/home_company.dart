import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fura_fila/pagesCustomer/login_customer.dart';
import 'package:fura_fila/style/form_style.dart';

class HomeCompany extends StatefulWidget {
  const HomeCompany({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageCustomer();
}

class _HomePageCustomer extends State<HomeCompany> {
  final FormStyle _formStyle = FormStyle();
  String companyName = '';
  String imageCompanyExemple = 'assets/pf1.png';

  @override
  void initState() {
    super.initState();
    _getCompanyName();
  }

  Future<void> _getCompanyName() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String emailCompany = user?.email ?? '';

      if (emailCompany.isEmpty) {
        print('E-mail da empresa não encontrado!');
        return;
      }

      final companyQuery = await FirebaseFirestore.instance
          .collection('company')
          .where('emailCompany', isEqualTo: emailCompany)
          .get();

      if (companyQuery.docs.isNotEmpty) {
        setState(() {
          companyName = companyQuery.docs.first['nameCompany'];
        });
      } else {
        print('Empresa não encontrada!');
      }
    } catch (e) {
      print("Erro ao obter o nome da empresa: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Image.asset(
          "assets/titleHeader.png",
          height: 300,
        ),
        backgroundColor: const Color.fromRGBO(46, 10, 96, 1),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 40,
        ),
        centerTitle: true,
      ),
      drawer: _buildDrawer(context),
      body: Center(
        child: SingleChildScrollView(
          child: companyName.isNotEmpty
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    bool isMobile = constraints.maxWidth < 600;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 60, 0, 30),
                          child: isMobile
                              ? Column(
                                  children: [
                                    Image.asset(
                                      imageCompanyExemple,
                                      width: 350,
                                      height: 350,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Text(
                                        'Bem-vindo, $companyName',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 0, 20),
                                      child: Text(
                                        'Sua avaliação',
                                        style: TextStyle(fontSize: 24),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 20,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 20,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 20,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 20,
                                          ),
                                          Icon(
                                            Icons.star_border,
                                            color: Colors.grey,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      imageCompanyExemple,
                                      width: 350,
                                      height: 350,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 0, 0, 0),
                                          child: Text(
                                            'Bem-vindo, $companyName',
                                            style:
                                                const TextStyle(fontSize: 24),
                                          ),
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 0, 20),
                                          child: Text(
                                            'Sua avaliação',
                                            style: TextStyle(fontSize: 24),
                                          ),
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 40,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 40,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 40,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 40,
                                              ),
                                              Icon(
                                                Icons.star_border,
                                                color: Colors.grey,
                                                size: 40,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
                          child: Text(
                            "Atendimentos já realizados: 150",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Text(
                            "Atendimentos do dia!!!",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                double fontSize =
                                    constraints.maxWidth < 600 ? 15 : 20;
                                double fontSizeTitle =
                                    constraints.maxWidth < 600 ? 20 : 30;

                                return DataTable(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          const Color.fromRGBO(46, 10, 96, 1),
                                      width: 3,
                                    ),
                                  ),
                                  columns: [
                                    DataColumn(
                                      label: Center(
                                        child: Text(
                                          'Número',
                                          style: TextStyle(
                                            fontSize: fontSizeTitle,
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromRGBO(
                                                46, 10, 96, 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Center(
                                        child: Text(
                                          'Horário',
                                          style: TextStyle(
                                            fontSize: fontSizeTitle,
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromRGBO(
                                                46, 10, 96, 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Center(
                                        child: Text(
                                          'Nome do Cliente',
                                          style: TextStyle(
                                            fontSize: fontSizeTitle,
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromRGBO(
                                                46, 10, 96, 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      DataCell(Text('1',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(fontSize: fontSize))),
                                      DataCell(Text('10:30 AM',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(fontSize: fontSize))),
                                      DataCell(Text('João Silva',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(fontSize: fontSize))),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('2',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(fontSize: fontSize))),
                                      DataCell(Text('11:00 AM',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(fontSize: fontSize))),
                                      DataCell(Text('Maria Oliveira',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(fontSize: fontSize))),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('3',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(fontSize: fontSize))),
                                      DataCell(Text('11:30 AM',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(fontSize: fontSize))),
                                      DataCell(Text('Carlos Pereira',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(fontSize: fontSize))),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('4',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(fontSize: fontSize))),
                                      DataCell(Text('12:00 PM',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(fontSize: fontSize))),
                                      DataCell(Text('Ana Costa',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(fontSize: fontSize))),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('5',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(fontSize: fontSize))),
                                      DataCell(Text('12:30 PM',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(fontSize: fontSize))),
                                      DataCell(Text('Lucas Santos',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(fontSize: fontSize))),
                                    ]),
                                  ],
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    );
                  },
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(46, 10, 96, 1),
            ),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Página inicial'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
