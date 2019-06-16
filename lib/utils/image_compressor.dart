import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart';

Future<File> _resizeImage(Map<String, dynamic> data) async {

    File imageFile = data['imageFile'];
    int width = data['width'];
    String imageTemporaryPath = data['imageTemporaryPath'];

    final bytes = imageFile.readAsBytesSync();
    print("Picture original size: ${bytes.length}");
    Im.Image image = Im.decodeImage(bytes);
    Im.Image resizedImage = Im.copyResize(image, width:(image.width < width? image.width:width));
    final resizedBytes = Im.encodeJpg(resizedImage, quality: 98);
    print("Picture resized size: ${resizedBytes.length}");
    File compressedImage = new File(imageTemporaryPath)..writeAsBytesSync(resizedBytes);
    return compressedImage;
  }

Future<File> compressImage({File imageFile, int width, @required String imageTemporaryPath}) async {
  File fileCompressed = await compute<Map<String, dynamic>, File>(_resizeImage, {'imageFile': imageFile, 'width': width, 'imageTemporaryPath':imageTemporaryPath});
  return fileCompressed;
}

Future<String> generateImageTempPath() async{

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = Random().nextInt(10000);
    return '$path/img_$rand.jpg';
}



// void compressImage() async {
//   File imageFile = await ImagePicker.pickImage();
//   final tempDir = await getTemporaryDirectory();
//   final path = tempDir.path;
//   int rand = new Math.Random().nextInt(10000);

//   Im.Image image = Im.decodeImage(imageFile.readAsBytesSync());
//   Im.Image smallerImage = Im.copyResize(image, 500); // choose the size here, it will maintain aspect ratio

//   var compressedImage = new File('$path/img_$rand.jpg')..writeAsBytesSync(Im.encodeJpg(image, quality: 85));
// }````