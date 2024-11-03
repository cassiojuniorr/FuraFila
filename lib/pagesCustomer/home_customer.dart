import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fura_fila/pagesCustomer/login_customer.dart';
import 'package:fura_fila/style/form_style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePageCustomer extends StatefulWidget {
  const HomePageCustomer({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageCustomer();
}

class _HomePageCustomer extends State<HomePageCustomer> {
  final FormStyle _formStyle = FormStyle();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _companies = [];
  List<Map<String, dynamic>> _filteredCompanies = [];

  final List<String> images1 = [
    'assets/ya1.png',
    'assets/ya2.png',
    'assets/ya3.png',
    'assets/ya4.png',
    'assets/ya5.png',
  ];

  final List<String> images2 = [
    'assets/s1.png',
    'assets/s2.png',
    'assets/s3.png',
    'assets/s4.png',
    'assets/s5.png',
  ];

  final List<String> images3 = [
    'assets/g1.png',
    'assets/g2.png',
    'assets/g3.png',
    'assets/g4.png',
    'assets/g5.png',
  ];

  @override
  void initState() {
    super.initState();
    _fetchCompanies();
    _searchController.addListener(_filterCompanies);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCompanies() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCompanies = _companies
          .where((company) =>
              company['nameCompany']?.toLowerCase().contains(query) ?? false)
          .toList();
    });
  }

  Future<void> _fetchCompanies() async {
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final QuerySnapshot snapshot =
          await _firestore.collection('company').get();
      final companies = snapshot.docs.map((doc) {
        return {
          'nameCompany': doc['nameCompany'] ?? 'Sem Nome',
          'tags': List<String>.from(doc['tags'] ?? []),
        };
      }).toList();

      setState(() {
        _companies = companies;
        _filteredCompanies = companies;
      });
    } catch (e) {
      print("Erro ao buscar empresas: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = MediaQuery.of(context).size.width < 600 ? 1 : 2;

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: _formStyle
                  .fieldSearchStyle('Pesquise pelo nome do restaurante'),
            ),
          ),
          Expanded(
            child: _filteredCompanies.isEmpty
                ? const Center(child: Text('Nenhuma empresa cadastrada.'))
                : GridView.builder(
                    padding: const EdgeInsets.all(30),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: _filteredCompanies.length,
                    itemBuilder: (context, index) {
                      final company = _filteredCompanies[index];
                      List<String> images = getImagesForIndex(index);

                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(46, 10, 96, 1),
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: GridTile(
                          header: Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 20),
                            child: Text(
                              company['nameCompany'] ?? 'Sem Nome',
                              style: _formStyle.fieldCompanyName(context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          child: buildCarousel(images, company),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  List<String> getImagesForIndex(int index) {
    if (index % 3 == 0) {
      return images1;
    } else if (index % 3 == 1) {
      return images2;
    } else {
      return images3;
    }
  }

  Widget buildCarousel(List<String> images, Map<String, dynamic> company) {
    int currentIndex = 0;
    double screenWidth = MediaQuery.of(context).size.width;
    double carouselHeight = screenWidth < 600 ? screenWidth * 0.4 : 400;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: CarouselSlider.builder(
                  itemCount: images.length,
                  itemBuilder: (context, index, realIndex) {
                    return Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                      width: screenWidth < 600 ? screenWidth * 0.8 : 400,
                    );
                  },
                  options: CarouselOptions(
                    height: carouselHeight,
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            AnimatedSmoothIndicator(
              activeIndex: currentIndex,
              count: images.length,
              effect: const WormEffect(
                dotWidth: 10,
                dotHeight: 10,
                activeDotColor: Color.fromRGBO(46, 10, 96, 1),
                dotColor: Color.fromARGB(47, 225, 0, 255),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Tags: ${company['tags']?.join(", ") ?? 'Sem tags'}',
                style: _formStyle.fieldCompanyTag(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      },
    );
  }
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
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
            );
          },
        ),
      ],
    ),
  );
}
