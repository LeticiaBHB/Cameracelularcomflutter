import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initCamera();
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }

  late CameraController cameraController;
  late List<CameraDescription> cameras;

  var isCameraInitialized = false.obs;

  initCamera() async {
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();

      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.max,
      );
      await cameraController.initialize();
      isCameraInitialized(true);
      update();
    } else {
      print('Permission denied');
    }
  }

  void trocarCamera() async {
    if (cameras.length < 2) {
      // Não há câmeras suficientes para alternar
      return;
    }

    // Verifique a câmera atualmente ativa
    int cameraIndex = cameras.indexOf(cameraController.description);

    // Calcule o índice da próxima câmera
    int nextCameraIndex = (cameraIndex + 1) % cameras.length;

    // Troque para a próxima câmera
    await cameraController.dispose();
    cameraController = CameraController(
      cameras[nextCameraIndex],
      ResolutionPreset.max,
    );
    await cameraController.initialize();
    update();
  }
}
