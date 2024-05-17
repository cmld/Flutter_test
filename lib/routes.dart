import 'package:clmd_flutter/pages/ble_screen.dart';
import 'package:clmd_flutter/pages/chart_card_screen.dart';
import 'package:clmd_flutter/pages/lrScorll_screen.dart';
import 'package:clmd_flutter/pages/scanPluginPage.dart';
import 'package:flutter/material.dart';

import 'main.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/': (BuildContext context) =>
      const MyHomePage(title: 'Flutter Demo Home Page'),
  'fds': (BuildContext context) => FindDevicesScreen(),
  'cc': (BuildContext context) => const ChartCardScreen(),
  'lrs': (BuildContext context) => LrScorllScreen(),
  'spp': (BuildContext context) => ScanPluginPage(),
};
