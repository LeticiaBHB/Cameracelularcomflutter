import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:objectdetect/controller/scan_controller.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: OrientationBuilder(
            builder: (context, orientation) {
              // Determine a relação de aspecto com base na orientação da tela
              double aspectRatio = 1.0;
              if (orientation == Orientation.portrait) {
                aspectRatio = 3.0 / 4.0; // Exemplo de relação de aspecto para retrato
              } else {
                aspectRatio = 4.0 / 0.5; // Exemplo de relação de aspecto para paisagem
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (orientation == Orientation.portrait)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text('Câmera inteligente!', textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ScanController scanController = Get.find<ScanController>(); // Obtém o controle da câmera
                            scanController.trocarCamera(); // Chama a função para trocar a câmera
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.black),
                          child: Icon(Icons.switch_camera, color: Colors.white,), // Ícone para mudar a câmera

                        ),
                      ],
                    ),
                  GetBuilder<ScanController>(
                    init: ScanController(),
                    builder: (controller) {
                      return controller.isCameraInitialized.value
                          ? Expanded(
                            child: AspectRatio(
                        aspectRatio: aspectRatio, // Usando a relação de aspecto calculada
                        child: CameraPreview(controller.cameraController),
                      ),
                          )
                          : const Center(child: Text('Carregando visualização...'));
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

