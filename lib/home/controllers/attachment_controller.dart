import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class AttachmentController extends GetxController {
  ImagePicker imagePicker = ImagePicker();
  RxString path = ''.obs;

  Future<void> getCamera() async {
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    if (file != null) {
      path.value = file.path;
    }
  }

  Future<void> getImage() async {
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      path.value = file.path;
    }
  }

  Future<void> getDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
    );

    if (result != null && result.files.single.path != null) {
      path.value = result.files.single.path!;
    }
  }

  bool isImage() {
    final List<String> imageExtensions = ['jpg', 'jpeg', 'png', 'gif'];
    String ext = path.value.split('.').last.toLowerCase();
    return imageExtensions.contains(ext);
  }

  String getFileName() {
    return path.value.split('/').last;
  }
}
