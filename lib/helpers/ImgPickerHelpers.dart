import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fura_fila/services/selected_images.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class ImgPickerHelpers {
  ValueNotifier<File?> selectedImage = ValueNotifier<File?>(null);
  SelectedImages selectedImages = SelectedImages();

  void pickMultipleImages() async {
    if (kIsWeb) {
      final pickedFile = ImagePicker();
      final List<XFile> images = await pickedFile.pickMultiImage();

      if (images.isNotEmpty) {
        for (var image in images) {
          await uploadImage(image);
        }
      }
    } else {
      var storageStatus = await Permission.storage.status;
      if (!storageStatus.isGranted) {
        await Permission.storage.request();
      }
      if (storageStatus.isGranted) {
        final pickedFile = ImagePicker();
        final List<XFile> images = await pickedFile.pickMultiImage();

        if (images.isEmpty) {
          selectedImages.pickedImages.addAll(images);
        }
      }
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage == null) {
        print("Nenhuma imagem selecionada");
        return;
      }

      if (kIsWeb) {
        await uploadImage(pickedImage);
      } else {
        final Directory appDirectory = await getApplicationDocumentsDirectory();
        final String directoryPath = path.join(appDirectory.path, 'imgCompany');
        final Directory directory = Directory(directoryPath);
        if (!(await directory.exists())) {
          await directory.create(recursive: true);
        }

        final String fileName = path.basename(pickedImage.path);
        final String filePath = path.join(directoryPath, fileName);

        final File localImage = await File(pickedImage.path).copy(filePath);

        selectedImage.value = localImage;
        print('Imagem salva em: $filePath');
      }
    } catch (e) {
      print("Erro ao salvar a imagem: $e");
    }
  }

  Future<void> uploadImage(XFile image) async {
    try {
      final imageBytes = await image.readAsBytes();
      final fileName = image.name;

      final uri = Uri.parse('http://10.0.0.190:3000/upload');

      final request = http.MultipartRequest('POST', uri)
        ..files.add(http.MultipartFile.fromBytes(
          'image', 
          imageBytes, 
          filename: fileName, 
          contentType: MediaType('image', 'jpg')
        ));

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Imagem enviada com sucesso.');
      } else {
        print('Falha ao enviar imagem. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Erro ao enviar a imagem: $e");
    }
  }
}
