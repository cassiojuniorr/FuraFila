import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fura_fila/services/selected_images.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class ImgPickerHelpers {
  ValueNotifier<File?> selectedImage = ValueNotifier<File?>(null);
  SelectedImages selectedImages = SelectedImages();

  void pickMultipleImages() async {
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

  Future<void> pickImageFromGallery() async {
    try {
      /* var storageStatus = await Permission.storage.status;
      if (!storageStatus.isGranted) {
        storageStatus = await Permission.storage.request();
        if (!storageStatus.isGranted) {
          print("Permissão de armazenamento negada");
          return;
        }
      } */

      final XFile? returnedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (returnedImage == null) {
        print("Nenhuma imagem selecionada");
        return;
      }

      final Directory appDirectory = await getApplicationDocumentsDirectory();
      final String directoryPath = path.join(appDirectory.path, 'imgCompany');
      print(directoryPath);

      final Directory directory = Directory(directoryPath);
      if (!(await directory.exists())) {
        await directory.create(recursive: true);
      }

      final String fileName = path.basename(returnedImage.path);
      final String filePath = path.join(directoryPath, fileName);

      final File localImage = await File(returnedImage.path).copy(filePath);

      selectedImage.value = localImage;

      print('Imagem salva em: $filePath');
    } catch (e) {
      print("Erro ao salvar a imagem: $e");
    }
  }
}
