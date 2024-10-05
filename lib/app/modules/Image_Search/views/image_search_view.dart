// import 'package:flutter/material.dart';

// import 'package:get/get.dart';

// import '../controllers/image_search_controller.dart';

// class ImageSearchView extends GetView<ImageSearchController> {
//   const ImageSearchView({super.key});
import 'dart:io';
import 'package:eccomerce_app/app/components/TextField/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:palette_generator/palette_generator.dart';

class ImageSearchView extends StatefulWidget {
  const ImageSearchView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ImageSearchViewState createState() => _ImageSearchViewState();
}

class _ImageSearchViewState extends State<ImageSearchView> {
  final MobileScannerController cameraController = MobileScannerController();
  File? _image;
  Color? _dominantColor;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    cameraController.start();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      setState(() {
        _image = image;
      });
      _getDominantColor(image);
    }
  }

  Future<void> _getDominantColor(File imageFile) async {
    final image = Image.file(imageFile);
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(image.image);
    setState(() {
      _dominantColor = paletteGenerator.dominantColor?.color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Iconsax.arrow_circle_left,
              size: 30,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: true,
          title: Text("Searching...")),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  MobileScanner(
                    controller: cameraController,
                    fit: BoxFit.cover,
                    onDetect: (barcodeCapture) {
                      final List<Barcode> barcodes = barcodeCapture.barcodes;
                      for (final barcode in barcodes) {
                        final String? code = barcode.rawValue;
                        if (code != null) {
                          Get.snackbar('Product Found', code);
                        }
                      }
                    },
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withOpacity(0.8),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (_image != null) ...[
              const Text('Uploaded Image:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Image.file(_image!, height: 100, width: 100),
              const SizedBox(height: 8),
              if (_dominantColor != null)
                Text(
                  'Dominant Color: ${_dominantColor.toString()}',
                  style: const TextStyle(fontSize: 16),
                ),
            ],
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Iconsax.folder, color: AppColors.primaryColor),
                    onPressed: _pickImage,
                  ),
                  const SizedBox(width: 40),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Iconsax.camera,
                        color: AppColors.whiteColor,
                      ),
                      color: Colors.white,
                      iconSize: 36,
                      onPressed: () {
                        cameraController.toggleTorch();
                      },
                    ),
                  ),
                  const SizedBox(width: 40),
                  IconButton(
                    icon: const Icon(Iconsax.refresh,
                        color: AppColors.primaryColor),
                    onPressed: () {
                      cameraController.start();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
