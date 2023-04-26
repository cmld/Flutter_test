import 'dart:math';

import 'package:clmd_flutter/components/comment_chart_view.dart';
import 'package:clmd_flutter/components/manage_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChartCard extends StatefulWidget {
  const ChartCard({required this.getData, Key? key}) : super(key: key);

  final Future<List<MyCandleItem>> Function(int) getData;

  @override
  _ChartCardState createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  final ValueNotifier<int> _index = ValueNotifier(1);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(0.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ManageMultipleSwitch(
              const ['日', '周', '月', '季', '年'],
              onCallBack: (index) {
                _index.value = index;
              },
              initIndex: _index.value,
            ),
            Divider(
              height: 14.h,
              color: Colors.transparent,
            ),
            ValueListenableBuilder(
              valueListenable: _index,
              builder: (c, int v, p) => FutureBuilder(
                future: widget.getData(v),
                builder: (c, snp) {
                  switch (snp.connectionState) {
                    case ConnectionState.none:
                      return const Center(child: Icon(Icons.error));
                    case ConnectionState.waiting:
                      return SizedBox(
                        height: ScreenUtil().screenHeight / 3,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    default:
                      List<double> step = [12, 6, 7, 10, 4];

                      List<MyCandleItem> currentData =
                          handleData(v, snp.requireData);

                      return CandleChart(
                        sourceData: currentData,
                        headerInfoBuild: (index) => Column(
                          children: [
                            Text('$index ${currentData[index].title}'),
                            Text(
                                '${currentData[index].min} ~ ${currentData[index].max}'),
                          ],
                        ),
                        headerW: 60,
                        titleInfoBuild: () => SizedBox(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('data - $v'),
                          ),
                          height: 60,
                        ),
                        vAxisStep: step[v],
                        vaTitle: showValueforIndex(v),
                      );
                  }
                },
              ),
            ),
            Divider(
              height: 14.h,
              color: Colors.transparent,
            ),
            Align(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: '注：绿色 范围内（25～40）相对安全'.substring(0, 2),
                        style: TextStyle(fontSize: 10.5.sp)),
                    TextSpan(
                        text: '注：绿色 范围内（25～40）相对安全'.substring(2, 4),
                        style: TextStyle(
                            fontSize: 10.5.sp, backgroundColor: Colors.green)),
                    TextSpan(
                        text: '注：绿色 范围内（25～40）相对安全'.substring(4),
                        style: TextStyle(fontSize: 10.5.sp)),
                  ],
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
          ],
        ),
      ),
    );
  }

  List<MyCandleItem> handleData(int type, List<MyCandleItem> data) {
    List<MyCandleItem> resultData = [];

    switch (type) {
      // case 0: // 日  颗粒度为2/hour 刻度6hour
      //   List<MyCandleItem> temp = [];
      //   for (MyCandleItem element in data) {
      //     temp.add(element);
      //     if (temp.length == 6) {
      //       resultData.add(MyCandleItem(
      //         temp.map((e) => e.min).reduce(min),
      //         temp.map((e) => e.max).reduce(max),
      //         title: '',
      //         creatTime: element.creatTime,
      //       ));
      //       temp = [];
      //     }
      //   }

      //   break;
      // case 1: // 周  颗粒度为6/day 刻度1day

      //   List<MyCandleItem> temp = [];
      //   for (MyCandleItem element in data) {
      //     temp.add(element);
      //     if (temp.length == 48) {
      //       resultData.add(MyCandleItem(
      //         temp.map((e) => e.min).reduce(min),
      //         temp.map((e) => e.max).reduce(max),
      //         title: '',
      //         creatTime: element.creatTime,
      //       ));
      //       temp = [];
      //     }
      //   }

      //   break;
      // case 2: // 月  颗粒度为1/day 刻度7day

      //   resultData = data;

      //   break;
      case 3: // 季  颗粒度为10/month 刻度1month

        int tempMonth = 0;
        List<MyCandleItem> temp = [];
        for (MyCandleItem element in data) {
          if (element == data.last) {
            temp.add(element);
          }
          if (tempMonth != element.creatTime?.month || element == data.last) {
            int index = 0;
            List<MyCandleItem> weektemp = [];
            for (MyCandleItem item in temp) {
              weektemp.add(item);
              if ((index != 9 && weektemp.length == 3) || item == temp.last) {
                resultData.add(MyCandleItem(
                  weektemp.map((e) => e.min).reduce(min),
                  weektemp.map((e) => e.max).reduce(max),
                  title: weektemp.first.title,
                  creatTime: item.creatTime,
                ));

                index += 1;
                weektemp = [];
              }
            }

            temp = [];
            tempMonth = element.creatTime!.month;
          }

          temp.add(element);
        }

        break;
      case 4: // 年 颗粒度为4/month 刻度1month

        int tempMonth = 0;
        List<MyCandleItem> temp = [];
        for (MyCandleItem element in data) {
          if (element == data.last) {
            temp.add(element);
          }
          if (tempMonth != element.creatTime?.month || element == data.last) {
            int index = 0;
            List<MyCandleItem> weektemp = [];
            for (MyCandleItem item in temp) {
              weektemp.add(item);
              if ((index != 3 && weektemp.length == 7) || item == temp.last) {
                resultData.add(MyCandleItem(
                  weektemp.map((e) => e.min).reduce(min),
                  weektemp.map((e) => e.max).reduce(max),
                  title: weektemp.first.title,
                  creatTime: item.creatTime,
                ));

                index += 1;
                weektemp = [];
              }
            }

            temp = [];
            tempMonth = element.creatTime!.month;
          }

          temp.add(element);
        }

        break;

      default:
        resultData = data;

        break;
    }

    return resultData;
  }

  List<String> showValueforIndex(int index) {
    List<String> result = [];
    switch (index) {
      case 0:
        result = List.generate(4, (index) => '${index * 6}时');
        break;
      case 1:
        result = ['週一', '週二', '週三', '週四', '週五', '週六', '週日'];
        break;
      case 2:
        int currentMonth = DateTime.now().month;
        result = List.generate(5, (index) => '$currentMonth/${index * 7 + 1}');
        break;
      case 3:
        int currentMonth = DateTime.now().month;
        int firstMonth = ((currentMonth - 1) ~/ 3) * 3 + 1;
        result = ['$firstMonth月', '${firstMonth + 1}月', '${firstMonth + 2}月'];
        break;
      case 4:
        result = List.generate(12, (index) => '${index + 1}月');
        break;
      default:
    }

    return result;
  }
}
