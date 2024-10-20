import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fura_fila/pagesCustomer/login_customer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomePageCustomer extends StatefulWidget {
  const HomePageCustomer({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePageCustomer> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> _fetchCompanies() async {
    try {
      // Obtendo documentos da coleção 'company'
      QuerySnapshot snapshot = await _firestore.collection('company').get();

      // Verificar quantos documentos foram retornados
      print("Número de empresas encontradas: ${snapshot.docs.length}");

      if (snapshot.docs.isEmpty) {
        return [];
      }

      // Lista de empresas com imagens incluídas
      List<Map<String, dynamic>> companiesWithImages = [];

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final companyId = doc.id;

        // Log para depuração
        print("Empresa ID: $companyId, Nome: ${data['nameCompany']}");

        // Busca as imagens da empresa
        List<File> images = await _getCompanyImages(companyId);

        // Adiciona os dados da empresa e as imagens à lista
        companiesWithImages.add({
          'id': companyId,
          'nameCompany': data['nameCompany'] ?? 'Nome não disponível',
          'tags': data['tags'] ?? [],
          'images': images, // Adiciona as imagens aqui
        });
      }

      return companiesWithImages;
    } catch (e) {
      // Log do erro
      print("Erro ao carregar empresas: $e");
      return [];
    }
  }

  Future<List<File>> _getCompanyImages(String? companyId) async {
    if (companyId == null) return [];

    if (kIsWeb) {
      print("Executando no Web - Sem suporte para arquivos locais.");
      return [];
    }

    final directory = await getApplicationDocumentsDirectory();
    final companyDirPath = '${directory.path}/imgCompany/$companyId';
    final companyDir = Directory(companyDirPath);

    print("Buscando imagens no diretório: $companyDirPath");

    if (await companyDir.exists()) {
      final files = companyDir.listSync().whereType<File>().toList();
      print("Imagens encontradas: ${files.length}");
      return files;
    } else {
      print("Diretório não encontrado: $companyDirPath");
    }

    return [];
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchCompanies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma empresa cadastrada.'));
          }

          List<Map<String, dynamic>> companies = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            itemCount: companies.length,
            itemBuilder: (context, index) {
              final company = companies[index];
              List<File> images = company['images'];

              return GridTile(
                header: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    company['nameCompany'] ?? 'Sem Nome',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                footer: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Tags: ${company['tags']?.join(", ") ?? 'Sem tags'}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                child: images.isNotEmpty
                    ? Image.file(
                        images.first,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/no_image_available.png',
                        fit: BoxFit.cover,
                      ),
              );
            },
          );
        },
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
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
