import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  final ImagePicker _imagePicker = ImagePicker();

  /// Get image from gallery
  /// Returns image path
  Future<String?> getImagePathGallery({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    XFile? pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
    );
    return pickedFile?.path;
  }

  /// Get image from camera
  /// Returns image path
  Future<String?> getImagePathCamera({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice: CameraDevice.rear,
  }) async {
    XFile? pickedFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
      preferredCameraDevice: preferredCameraDevice,
    );
    return pickedFile?.path;
  }
}