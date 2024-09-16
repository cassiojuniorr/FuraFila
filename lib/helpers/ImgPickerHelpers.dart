import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fura_fila/services/auth_service.dart';
import 'package:fura_fila/services/selected_images.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:fura_fila/core/snack_bar.dart';

class ImgPickerHelpers {
  ValueNotifier<File?> selectedImage = ValueNotifier<File?>(null);
  SelectedImages selectedImages = SelectedImages();
  AuthService authService = AuthService();
  final ImagePicker _picker = ImagePicker();

  void pickMultipleImages(BuildContext context) async {
    if (kIsWeb) {
      final _picker = ImagePicker();
      final List<XFile> images = await _picker.pickMultiImage();

      if (images.isNotEmpty) {
        for (var image in images) {
          await uploadImage(image, context);
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

  Future<Uint8List?> pickImageFromGallery(BuildContext context) async {
    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      final String? idUser = await authService.getIdUser();
      if (pickedImage == null || idUser == null) {
        print("Nenhuma imagem selecionada ou ID do usuário não encontrado");
        showSnackBar(
          context: context,
          text: "Nenhuma imagem selecionada ou ID do usuário não encontrado",
        );
        return null;
      }

      if (kIsWeb) {
        await uploadImage(pickedImage, context);
      } else {
        final Directory appDirectory = await getApplicationDocumentsDirectory();
        final String directoryPath = path.join(appDirectory.path, idUser);
        final Directory directory = Directory(directoryPath);

        if (!(await directory.exists())) {
          await directory.create(recursive: true);
          print('Diretório criado em: $directory');
        } else {
          print('Diretório já existe em: $directory');
        }

        final String fileName = "${idUser}_${path.basename(pickedImage.path)}";
        final String filePath = path.join(directoryPath, fileName);

        final File localImage = await File(pickedImage.path).copy(filePath);

        selectedImage.value = localImage;
        print('Imagem salva em: $filePath');
      }

      if (pickedImage.path.isNotEmpty) {
        return await pickedImage.readAsBytes();
      }
    } catch (e) {
      print("Erro ao salvar a imagem: $e");
    }
    return null;
  }

  Future<void> pickImageFromCamera(BuildContext context) async {
    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.camera);
      final String? idUser = await authService.getIdUser();

      if (pickedImage == null) {
        print("Nenhuma imagem capturada");
        return;
      }

      if (kIsWeb) {
        await uploadImage(pickedImage, context);
      } else {
        final Directory appDirectory = await getApplicationDocumentsDirectory();
        final String directoryPath =
            path.join(appDirectory.path, 'imgCompany', idUser);
        final Directory directory = Directory(directoryPath);

        if (!(await directory.exists())) {
          await directory.create(recursive: true);
        }

        final String fileName = "${idUser}_${path.basename(pickedImage.path)}";
        final String filePath = path.join(directoryPath, fileName);

        final File localImage = await File(pickedImage.path).copy(filePath);

        selectedImage.value = localImage;
        print('Imagem salva em: $filePath');
      }
    } catch (e) {
      print("Erro ao capturar a imagem: $e");
    }
  }

  Future<void> uploadImage(XFile image, BuildContext context) async {
    try {
      final String? idUser = await authService.getIdUser();
      final imageBytes = await image.readAsBytes();
      final fileName = "${idUser}_${image.name}";

      final uri = Uri.parse('http://10.0.0.190:3000/upload');

      final request = http.MultipartRequest('POST', uri)
        ..files.add(http.MultipartFile.fromBytes('image', imageBytes,
            filename: fileName, contentType: MediaType('image', 'jpg')));

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Imagem enviada com sucesso.');
        showSnackBar(
          context: context,
          text: "Imagem enviada com sucesso.",
          isErro: false,
        );
      } else {
        print('Falha ao enviar imagem. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Erro ao enviar a imagem: $e");
    }
  }
}
