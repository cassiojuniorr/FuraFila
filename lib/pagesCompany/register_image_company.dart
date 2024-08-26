import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fura_fila/helpers/ImgPickerHelpers.dart';
import 'package:fura_fila/style/form_style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class RegisterImageCompany extends StatefulWidget {
  const RegisterImageCompany({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterImageCompany();
}

class _RegisterImageCompany extends State<RegisterImageCompany> {
  int currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  final ImgPickerHelpers _imgPickerHelpers = ImgPickerHelpers();

  final urlImages = [
    'assets/pictureDefaultGrad.png',
    'assets/pictureDefaultGrad.png',
    'assets/pictureDefaultGrad.png',
    'assets/pictureDefaultGrad.png',
    'assets/pictureDefaultGrad.png',
  ];

  @override
  Widget build(BuildContext context) {
    FormStyle _formStyle = FormStyle();
    return Scaffold(
      backgroundColor: const Color.fromARGB(5, 5, 5, 5),
      appBar: AppBar(
        title: const Text(
          'Adicione as imagens',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(46, 10, 96, 1),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 40,
        ),
        centerTitle: true,
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
                    final urlImage = urlImages[index];
                    return buildImages(urlImage, index);
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
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: _imgPickerHelpers.pickImageFromGallery,
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 14),
                      backgroundColor: const Color.fromRGBO(46, 10, 96, 1)),
                  child: const Text(
                    'Adicionar imagens',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImages(String urlImage, int index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 1),
        color: Colors.grey,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      );

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: currentIndex,
      count: 5,
      onDotClicked: animateToSlide,
      effect: const WormEffect(
        dotWidth: 20,
        dotHeight: 20,
        activeDotColor: Color.fromRGBO(46, 10, 96, 1),
        dotColor: Colors.black12,
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
                backgroundColor: const Color.fromRGBO(46, 10, 96, 1)),
            onPressed: previous,
            child: const Icon(
              Icons.arrow_back,
              size: 32,
              color: Colors.white,
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
                backgroundColor: const Color.fromRGBO(46, 10, 96, 1)),
            onPressed: next,
            child: const Icon(
              Icons.arrow_forward,
              size: 32,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      );

  void next() =>
      _controller.nextPage(duration: const Duration(microseconds: 500));
  void previous() =>
      _controller.previousPage(duration: const Duration(microseconds: 500));
  void animateToSlide(int index) => _controller.animateToPage(index);
}
