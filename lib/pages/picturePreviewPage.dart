import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PicturePreviewPage extends StatefulWidget {
  final String filePath;
  const PicturePreviewPage({Key? key, required this.filePath})
      : super(key: key);

  @override
  _PicturePreviewPageState createState() => _PicturePreviewPageState();
}

class _PicturePreviewPageState extends State<PicturePreviewPage> {
  final MethodChannel _channel = const MethodChannel('plugin_clmd');
  late final String waterPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(future: Future(() async {
              waterPath = await _channel.invokeMethod('imgWater', [
                widget.filePath,
                "656516516516\n31.654564,121.654655\n中国上海青浦区华东路来老师会计法1231号\n2023-11-56 18:23:23"
              ]);
              if (waterPath.isNotEmpty) {
                File(widget.filePath).delete();
              }
            }), builder: (c, p) {
              if (p.connectionState == ConnectionState.done) {
                return Center(
                  child: InteractiveViewer(
                    panEnabled: true, // Set it to false to prevent panning.
                    minScale: 0.5,
                    maxScale: 4,
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.file(File(waterPath)),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () async {
                    File(waterPath).delete();
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.red)),
                    ),
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.red, width: 1.5)),
                    foregroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  child: const Text('删除', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                ),
                OutlinedButton(
                  onPressed: () async {
                    File(waterPath).delete();
                    Navigator.popUntil(context, (route) {
                      return route.settings.name == '/';
                    });
                  },
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.red)),
                    ),
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.red, width: 1.5)),
                    foregroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  child: const Text('确定', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
