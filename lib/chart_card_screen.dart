import 'dart:math';

import 'package:clmd_flutter/components/comment_chart_view.dart';
import 'package:clmd_flutter/components/chart_card.dart';
import 'package:clmd_flutter/models/report.dart';
import 'package:clmd_flutter/utils/network.dart';
import 'package:flutter/material.dart';

class ChartCardScreen extends StatefulWidget {
  const ChartCardScreen({Key? key}) : super(key: key);

  @override
  _ChartCardState createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('chart')),
      body: Center(
        child: ChartCard(
          getData: (index) {
            return fullData(index);
          },
        ),
      ),
    );
  }

  Future<List<MyCandleItem>> fullData(int type) async {
    ReportData data = await Api.postData(
        'http://tw2api.xiinhealthtech.com/api/v5/report/report-hrv-basic',
        getParams(type, DateTime.now()),
        'lf');

    List<MyCandleItem> reslut = [];

    data.dataAgg?.forEach((e) {
      double min = e.min ?? 0.0;
      double max = e.max ?? 0.0;
      reslut.add(MyCandleItem(min, max,
          title: e.datetime, creatTime: DateTime.parse(e.datetime ?? '')));
    });

    // double multiple = 10;
    // double testData = Random().nextDouble() * 10 * multiple;
    // List countList = [288, 2016, 31, 90, 365];
    // reslut = List.generate(
    //     countList[type],
    //     (index) => MyCandleItem(
    //         testData - Random().nextDouble() * multiple, testData,
    //         title: '数据：${testData.toStringAsFixed(2)}',
    //         creatTime: type > 1
    //             ? DateTime(2023, 1, 1 + index)
    //             : DateTime(2023, 1, 1, 0, 0 + index * 5)));

    return reslut;
  }

  Map getParams(int type, DateTime currentDate) {
    Map result = {};

    late DateTime start;
    late DateTime end;
    switch (type) {
      case 0:
        start = DateTime(currentDate.year, currentDate.month, currentDate.day);
        end = DateTime(start.year, start.month, start.day + 1)
            .add(const Duration(seconds: -1));
        result['aggregat_mins'] = 30;
        break;
      case 1:
        start = DateTime(currentDate.year, currentDate.month,
            currentDate.day - currentDate.weekday + 1);
        end = DateTime(start.year, start.month, start.day + 7)
            .add(const Duration(seconds: -1));
        result['aggregat_mins'] = 240;
        break;
      case 2:
        start = DateTime(currentDate.year, currentDate.month);
        end = DateTime(start.year, start.month + 1)
            .add(const Duration(seconds: -1));
        result['aggregat_mins'] = 1440;
        break;
      case 3:
        start =
            DateTime(currentDate.year, ((currentDate.month - 1) ~/ 3) * 3 + 1);
        end = DateTime(start.year, start.month + 3)
            .add(const Duration(seconds: -1));
        result['aggregat_mins'] = 1440;
        break;
      case 4:
        start = DateTime(currentDate.year);
        end = DateTime(start.year + 1).add(const Duration(seconds: -1));
        result['aggregat_mins'] = 1440;
        break;
      default:
    }
    result['start_datetime'] = start.toIso8601String();
    result['end_datetime'] = end.toIso8601String();

    print(result.toString());
    return result;
  }

  List<MyCandleItem> mockData(int type) {
    List counts = [48, 42, 31, 30, 48];
    List<MyCandleItem> resultData = List.generate(counts[type], (index) {
      var testData = Random().nextDouble() * 100;
      return MyCandleItem(testData - Random().nextDouble() * 50, testData,
          title: '数据：${testData.toStringAsFixed(2)}',
          creatTime: type > 1
              ? DateTime(2023, 1, 1 + index)
              : DateTime(2023, 1, 1, 0, 0 + index * 5));
    });
    return resultData;
  }
}
