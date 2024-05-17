import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_plugin/ScanObjController.dart';
import 'package:scan_plugin/ScanObjWidget.dart';

class ScanPluginPage extends StatefulWidget {
  const ScanPluginPage({Key? key}) : super(key: key);

  @override
  _ScanPluginPageState createState() => _ScanPluginPageState();
}

class _ScanPluginPageState extends State<ScanPluginPage> {
  late ScanObjController _scanObjctrl;

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
        title: Text('Scan Plugin'),
      ),
      body: Stack(
        children: [
          ScanObjWidget(
            controller: _scanObjctrl,
          ),
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: IconButton.filled(
              onPressed: () async {
                var file = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (file == null) return;
                var result = await _scanObjctrl.fileAnalysis(filePath: file.path);
                _scanObjctrl.resetEmptyParse();
                print(result);
              },
              icon: const Icon(Icons.image_search_outlined),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: IconButton.filled(
              onPressed: () async {
                var captureAnalysis = await _scanObjctrl.captureAnalysis();
                _scanObjctrl.resetEmptyParse();
                print(captureAnalysis);
              },
              icon: const Icon(Icons.camera),
            ),
          ),
        ],
      ),
    );
  }
}
