import 'package:clmd_flutter/ble_screen.dart';
import 'package:clmd_flutter/chart_card_screen.dart';
import 'package:clmd_flutter/lrScorll_screen.dart';
import 'package:flutter/material.dart';

import 'main.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/': (BuildContext context) =>
      const MyHomePage(title: 'Flutter Demo Home Page'),
  'fds': (BuildContext context) => FindDevicesScreen(),
  'cc': (BuildContext context) => const ChartCardScreen(),
  'lrs': (BuildContext context) => LrScorllScreen(),
};
