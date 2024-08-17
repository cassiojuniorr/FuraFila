import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class PathService {
  Future<Directory> _getDirectory() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory;
  }

  Future<void> saveImages(List<File> imageFiles) async {
    Directory directory = await _getDirectory();

    for (int i = 0; i < imageFiles.length; i++) {
      String fileName = 'empresa_${i + 1}.png';
      String filePath = path.join(directory.path, fileName);

      await imageFiles[i].copy(filePath);
    }
  }

  Future<void> saveCompanyImages(List<File> images) async {
    if (images.length != 4) {
      throw Exception('Você precisa fornecer exatamente 4 imagens.');
    }
    await saveImages(images);
  }
}
