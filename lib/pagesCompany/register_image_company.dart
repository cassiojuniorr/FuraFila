import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fura_fila/core/snack_bar.dart';
import 'package:fura_fila/helpers/ImgPickerHelpers.dart';
import 'package:fura_fila/services/company_service.dart';
import 'package:fura_fila/style/form_style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RegisterImageTagCompany extends StatefulWidget {
  const RegisterImageTagCompany({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterImageCompany();
}

class _RegisterImageCompany extends State<RegisterImageTagCompany> {
  int currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  final ImgPickerHelpers _imgPickerHelpers = ImgPickerHelpers();

  final List<Uint8List?> imageBytes = List<Uint8List?>.filled(5, null);
  final List<String> urlImages = [
    'assets/pictureDefaultGrad.png',
    'assets/pictureDefaultGrad.png',
    'assets/pictureDefaultGrad.png',
    'assets/pictureDefaultGrad.png',
    'assets/pictureDefaultGrad.png',
  ];

  final List<String> tagList = [];
  final CompanyService _companyService = CompanyService();

  bool validTag(String tagValue) {
    if (tagList.contains(tagValue)) {
      showSnackBar(context: context, text: "Esta tag já está cadastrada!!");
      return false;
    }
    return true;
  }

  void addTag(String tagValue) {
    if (validTag(tagValue)) {
      tagList.add(tagValue);
      print(tagList);
    }
  }

  @override
  Widget build(BuildContext context) {
    FormStyle _formStyle = FormStyle();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(46, 10, 96, 1),
      appBar: AppBar(
        title: const Text(
          'Adicione as Imagens e Tags',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(46, 10, 96, 1),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 40,
        ),
        centerTitle: true,
        elevation: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, right: 40, left: 40),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider.builder(
                  carouselController: _controller,
                  itemCount: urlImages.length,
                  itemBuilder: (context, index, realIndex) {
                    return buildImages(index);
                  },
                  options: CarouselOptions(
                    height: 400,
                    initialPage: 0,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                buildIndicator(),
                const SizedBox(height: 30),
                buildButtons(),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Adicione as Tags",
                  style: TextStyle(
                    fontSize: 34,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio:
                      3,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        addTag("Bar");
                      },
                      style: _formStyle.fieldButtonTags(),
                      child: Text(
                        'Bar',
                        style: _formStyle.fieldTextTags(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addTag("Supermecado");
                      },
                      style: _formStyle.fieldButtonTags(),
                      child: Text(
                        'Supermecado',
                        style: _formStyle.fieldTextTags(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addTag("Hamburgueria");
                      },
                      style: _formStyle.fieldButtonTags(),
                      child: Text(
                        'Hamburgueria',
                        style: _formStyle.fieldTextTags(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addTag("Restaurante Vegano");
                      },
                      style: _formStyle.fieldButtonTags(),
                      child: Text(
                        'Restaurante Vegano',
                        style: _formStyle.fieldTextTags(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addTag("Churrascaria");
                      },
                      style: _formStyle.fieldButtonTags(),
                      child: Text(
                        'Churrascaria',
                        style: _formStyle.fieldTextTags(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addTag("Pizzaria");
                      },
                      style: _formStyle.fieldButtonTags(),
                      child: Text(
                        'Pizzaria',
                        style: _formStyle.fieldTextTags(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addTag("Comida Japonesa");
                      },
                      style: _formStyle.fieldButtonTags(),
                      child: Text(
                        'Comida Japonesa',
                        style: _formStyle.fieldTextTags(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addTag("Sorveteria");
                      },
                      style: _formStyle.fieldButtonTags(),
                      child: Text(
                        'Sorveteria',
                        style: _formStyle.fieldTextTags(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addTag("Comida Italiana");
                      },
                      style: _formStyle.fieldButtonTags(),
                      child: Text(
                        'Comida Italiana',
                        style: _formStyle.fieldTextTags(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addTag("Entreterimento");
                      },
                      style: _formStyle.fieldButtonTags(),
                      child: Text(
                        'Entreterimento',
                        style: _formStyle.fieldTextTags(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    _companyService.addArray(tags: tagList, context: context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      side: const BorderSide(
                          width: 4.0, color: Color.fromRGBO(255, 255, 255, 1)),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      shadowColor: Colors.black),
                  child: const Text(
                    'FINALIZAR',
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromRGBO(46, 10, 96, 1),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImages(int index) {
    final urlImage = urlImages[index];
    final imageData = imageBytes[index];

    return GestureDetector(
      onTap: () async {
        await _replaceImage();
      },
      child: Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 1),
          color: Colors.grey,
          child: imageData != null
              ? Image.memory(imageData, fit: BoxFit.cover)
              : Image.asset(urlImage, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: currentIndex,
      count: urlImages.length,
      onDotClicked: animateToSlide,
      effect: const WormEffect(
        dotWidth: 20,
        dotHeight: 20,
        activeDotColor: Color.fromRGBO(255, 255, 255, 1),
        dotColor: Color.fromARGB(47, 225, 0, 255),
      ),
    );
  }

  Widget buildButtons({bool stretch = false}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
            onPressed: previous,
            child: const Icon(
              Icons.arrow_back,
              size: 32,
              color: const Color.fromRGBO(46, 10, 96, 1),
            ),
          ),
          stretch
              ? const Spacer()
              : const SizedBox(
                  width: 32,
                ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
            onPressed: next,
            child: const Icon(
              Icons.arrow_forward,
              size: 32,
              color: Color.fromRGBO(46, 10, 96, 1),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      );

  Future<void> _replaceImage() async {
    final Uint8List? pickedImage =
        await _imgPickerHelpers.pickImageFromGallery(context);
    if (pickedImage != null) {
      setState(() {
        imageBytes[currentIndex] = pickedImage;
      });
    }
  }

  void next() =>
      _controller.nextPage(duration: const Duration(microseconds: 500));
  void previous() =>
      _controller.previousPage(duration: const Duration(microseconds: 500));
  void animateToSlide(int index) => _controller.animateToPage(index);
}
