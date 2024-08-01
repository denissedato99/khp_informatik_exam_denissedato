import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khp_informatik_exam_denissedato/ui/camera/camera_view_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () async {
                  // Request camera permission
                  final request = await Permission.camera.request();

                  if (request.isGranted) {
                    if (context.mounted) {
                      final cameraViewModel = context.read<CameraViewModel>();
                      final ImagePicker picker = ImagePicker();
                      // Capture using camera
                      final XFile? photo =
                          await picker.pickImage(source: ImageSource.camera);
                      // Getting a directory path for saving
                      final String path =
                          (await getApplicationDocumentsDirectory()).path;

                      if (photo != null) {
                        // Save the file to a path
                        await photo.saveTo('$path/${photo.name}');
                        cameraViewModel.setImage(photo);
                        cameraViewModel.setImagePath(path);
                      }
                    }
                  } else {
                    if (context.mounted) {
                      _showPermissionDeniedErrorDialog(context);
                    }
                  }
                },
                child: const Text('Open Camera')),
            const SizedBox(
              height: 20,
            ),
            Consumer<CameraViewModel>(builder: (_, cameraViewModel, __) {
              return cameraViewModel.imagePath.isNotEmpty
                  ? Column(
                      children: [
                        if (cameraViewModel.selectedImage != null)
                          Image.file(
                            File(cameraViewModel.selectedImage!.path),
                            height: 400,
                            fit: BoxFit.cover,
                          ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'The image is saved in ${cameraViewModel.imagePath}',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : const SizedBox();
            })
          ],
        )),
      ),
    );
  }

  _showPermissionDeniedErrorDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Camera Permission Denied'),
            content: const Text(
                'Camera permission is required. Please allow camera permission in your device settings.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('DISMISS')),
              TextButton(
                child: const Text('GO TO SETTINGS'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  //final loginNotifier =
                  //context.read<LoggedInContainerChangeNotifier>();
                  //loginNotifier.setReturnToApp(true);
                  openAppSettings();
                },
              ),
            ],
          );
        });
  }
}
