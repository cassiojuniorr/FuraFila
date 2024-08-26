import 'package:image_picker/image_picker.dart';

class SelectedImages {
  static final SelectedImages _instance = SelectedImages._insternal();
  factory SelectedImages() => _instance;

  SelectedImages._insternal();
  List<XFile> pickedImages = [];
}
