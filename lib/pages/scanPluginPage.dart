import 'package:clmd_flutter/pages/picturePreviewPage.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:scan_plugin/ScanObjController.dart';
import 'package:scan_plugin/ScanObjWidget.dart';

/// JT内部扫描插件页面
class ScanPluginPage extends StatefulWidget {
  const ScanPluginPage({Key? key}) : super(key: key);

  @override
  _ScanPluginPageState createState() => _ScanPluginPageState();
}

class _ScanPluginPageState extends State<ScanPluginPage> {
  late ScanObjController _scanObjctrl;

  final ValueNotifier<bool> _isFlashOn = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _scanObjctrl = ScanObjController(
      initListener: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Plugin'),
      ),
      body: Stack(
        children: [
          ScanObjWidget(
            controller: _scanObjctrl,
          ),
          // const Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   child: DecoratedBox(
          //     decoration: BoxDecoration(color: Colors.grey),
          //     child: Row(
          //       children: [
          //         Icon(
          //           Icons.warning_amber_rounded,
          //           color: Colors.red,
          //         ),
          //         Text(
          //           'sdj',
          //           style: TextStyle(fontSize: 20),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // Positioned(
          //   bottom: 50,
          //   right: 20,
          //   child: IconButton.filled(
          //     onPressed: () async {
          //       var file =
          //           await ImagePicker().pickImage(source: ImageSource.gallery);
          //       if (file == null) return;
          //       var result =
          //           await _scanObjctrl.fileAnalysis(filePath: file.path);
          //       _scanObjctrl.resetEmptyParse();
          //       print(result);
          //       String path = result?['bitmap'];
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => PicturePreviewPage(filePath: path),
          //         ),
          //       );
          //     },
          //     icon: const Icon(Icons.image_search_outlined),
          //   ),
          // ),
          Positioned(
            bottom: 50,
            left: 20,
            child: IconButton(onPressed: () async {
                _scanObjctrl.enableTorch(!_isFlashOn.value);
                _isFlashOn.value = !_isFlashOn.value;
              },
              icon: ValueListenableBuilder(
                valueListenable: _isFlashOn,
                builder: (bc, value, w) {
                  return Icon(
                      value ? Icons.flash_on_rounded : Icons.flash_off_rounded);
                },
              ),),
          ),
          Positioned(
            bottom: 50,
            left: 80,
            right: 80,
            child: IconButton(
              onPressed: () async {
                var captureAnalysis = await _scanObjctrl.captureAnalysis();
                _scanObjctrl.resetEmptyParse();
                print(captureAnalysis);
                String path = captureAnalysis?['bitmap'];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PicturePreviewPage(filePath: path),
                  ),
                );
              },
              icon: const Icon(Icons.camera),
            ),
          ),
        ],
      ),
    );
  }
}
