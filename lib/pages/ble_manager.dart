import 'package:flutter_blue/flutter_blue.dart';

class BLEManager {
  FlutterBlue instance = FlutterBlue.instance..setLogLevel(LogLevel.debug);

  BluetoothDevice? _device;

  late BluetoothCharacteristic _mCharacteristic;
  late BluetoothCharacteristic _mWriteCharacteristic;

  void scan() async {
    Stream<ScanResult>? results = instance.scan();
    results.listen((result) {
      if (result.device.name == 'BW5VM1') {
        _device = result.device;

        _device!.connect(autoConnect: false);
        _service();

        instance.stopScan();
        results = null;
      }
    });
  }

  void _service() async {
    List<BluetoothService> services = await _device!.discoverServices();
    print(services.length);
    services.forEach((service) async {
      service.characteristics.forEach((c) {
        if (c.uuid.toString() == '00001002-0000-1000-8000-00805f9b34fb') {
          _mWriteCharacteristic = c;
        }
        if (c.uuid.toString() == '00001003-0000-1000-8000-00805f9b34fb') {
          _mCharacteristic = c;
        }
      });
      _mCharacteristic.setNotifyValue(true);
      _mCharacteristic.value.listen((event) {
        print('device is online:' + event.toString());
      });
    });
  }

  void write(List<int> content) {
    _mWriteCharacteristic.write(content);
  }
}
