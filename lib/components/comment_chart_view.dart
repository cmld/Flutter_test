import 'dart:math' as math;
import 'dart:math';
import 'package:charts_painter/chart.dart';
import 'package:clmd_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum chandleChartDateType { day, week, month, season }

// ignore: must_be_immutable
class CandleChart extends StatelessWidget {
  CandleChart(
      {required this.sourceData,
      required this.headerInfoBuild,
      required this.headerW,
      this.titleInfoBuild,
      this.safeArea,
      this.dataAxisMax,
      this.dataAxisMin,
      this.hAxisStep = 10,
      this.vAxisStep = 1,
      this.vaTitle,
      Key? key})
      : super(key: key);
  ValueNotifier<int> _selected = ValueNotifier(-1);

  double itemW = 7;
  List<MyCandleItem> sourceData;
  Widget? Function(int) headerInfoBuild;
  double headerW;

  Widget Function()? titleInfoBuild;

  ///制表安全区域范围，用于绘制渐变绿区域  传入两个值，[min,max]
  List<double>? safeArea;
  double? dataAxisMax; // 制表最大值
  double? dataAxisMin; // 制表最小值
  double hAxisStep; // 横坐标间距包含多少个单位数值
  double vAxisStep;
  List<String>? vaTitle;

  @override
  Widget build(BuildContext context) {
    double chartW = ScreenUtil().screenWidth - 40;

    double dataMax =
        (sourceData.map((e) => e.max).reduce(math.max).truncateToDouble() ~/
                    hAxisStep +
                1) *
            hAxisStep;

    double dataMin =
        sourceData.map((e) => e.max).reduce(math.min).truncateToDouble();

    dataMax = dataAxisMax ?? dataMax;
    dataMin = dataAxisMin ?? dataMin;

    double leftPaddingX = dataMax >= 6 * 17 ? 27 : (dataMax >= 6 * 2 ? 20 : 14);
    double partW = (chartW - leftPaddingX) / sourceData.length;

    ChartState cs = ChartState(
      /// 柱状图
      data: ChartData.fromList(
        sourceData.map((e) {
          return ChartItem(e.max, min: e.min);
        }).toList(),
        axisMax: dataMax,
        axisMin: dataMin,
      ),
      itemOptions: BarItemOptions(
        padding: EdgeInsets.only(
          left: partW / 2 - itemW / 2,
          right: partW / 2 - itemW / 2,
        ),
        barItemBuilder: (data) {
          return BarItem(
            color: (data.itemIndex == _selected.value || _selected.value < 0)
                ? CommonColors.primaryColor
                : CommonColors.primaryColor.withOpacity(0.4),
            radius: BorderRadius.circular(itemW / 2),
          );
        },
      ),
      backgroundDecorations: [
        GridDecoration(
          horizontalLegendPosition: HorizontalLegendPosition.start,
          horizontalValuesPadding: EdgeInsets.only(right: 5),
          horizontalAxisValueFromValue: ((value) => '$value'),
          verticalTextAlign: TextAlign.left,
          showHorizontalValues: true,
          horizontalAxisStep: dataMax > hAxisStep
              ? hAxisStep
              : max(((dataMax - dataMin) / 6).truncateToDouble(), 1),
          gridColor: Color.fromRGBO(181, 181, 181, 1),
          textStyle: TextStyle(
            fontSize: 12.sp,
            color: Color.fromRGBO(181, 181, 181, 1),
          ),
          showVerticalGrid: false,
        ),
        VerticalAxisDecoration(
          valueFromIndex: (index) => vaTitle?[index ~/ vAxisStep] ?? '$index',
          valuesPadding: EdgeInsets.only(top: 10, left: 2),
          showValues: true,
          valuesAlign: TextAlign.start,
          legendFontStyle: TextStyle(
            fontSize: 12.sp,
            color: Color.fromRGBO(181, 181, 181, 1),
          ),
          axisStep: vAxisStep,
          dashArray: [2, 4],
        ),
        if (safeArea != null)
          WidgetDecoration(widgetDecorationBuilder:
              ((context, chartState, itemWidth, verticalMultiplier) {
            double maxValue = chartState.data.maxValue;
            double minValue = chartState.data.minValue;

            double safeMax = safeArea?.last ?? 0;
            double safeMin = safeArea?.first ?? 0;

            bool isInArea = maxValue > safeMin || minValue < safeMax;

            return isInArea
                ? Container(
                    margin: EdgeInsets.only(
                        top: max(maxValue - safeMax, 0) * verticalMultiplier,
                        bottom:
                            max(safeMin - minValue, 0) * verticalMultiplier +
                                chartState.defaultMargin.bottom,
                        left: chartState.defaultMargin.left),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          CommonColors.secondColor.withOpacity(0.5),
                          CommonColors.secondColor.withOpacity(0.4),
                          CommonColors.secondColor.withOpacity(0.2),
                          Colors.white.withOpacity(0.01)
                        ],
                      ),
                    ),
                  )
                : SizedBox();
          }))
      ],
    );

    partW = (chartW - cs.defaultMargin.left) / sourceData.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder(
          valueListenable: _selected,
          builder: ((context, int selectedIndex, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (selectedIndex >= 0)
                  Container(
                    margin: EdgeInsets.only(
                      left: min(
                          max(
                              0,
                              ((selectedIndex + 0.5) * partW +
                                      cs.defaultMargin.left) -
                                  headerW / 2),
                          chartW - headerW),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: CommonColors.primaryColor,
                    ),
                    child: selectedIndex >= 0
                        ? headerInfoBuild(selectedIndex)
                        : null,
                  ),
                if (selectedIndex >= 0)
                  Container(
                    margin: EdgeInsets.only(
                      left:
                          (selectedIndex + 0.5) * partW + cs.defaultMargin.left,
                    ),
                    width: 1.w,
                    height: 17.5.h,
                    color: CommonColors.primary2Color,
                  ),
                if (selectedIndex < 0 && titleInfoBuild != null)
                  titleInfoBuild!(),
              ],
            );
          }),
        ),
        Stack(
          children: [
            GestureDetector(
              child: ValueListenableBuilder(
                valueListenable: _selected,
                builder: (c, v, b) => Chart(
                  height: ScreenUtil().screenHeight / 3,
                  width: chartW,
                  state: cs,
                ),
              ),
              behavior: HitTestBehavior.opaque,
              onPanUpdate: ((details) {
                var contentX = details.localPosition.dx - cs.defaultMargin.left;
                int index =
                    min((contentX / partW).truncate(), cs.data.listSize - 1);
                if (index != _selected.value) {
                  _selected.value = index;
                }
              }),
              onTapDown: ((details) {
                var contentX = details.localPosition.dx - cs.defaultMargin.left;
                int index =
                    min((contentX / partW).truncate(), cs.data.listSize - 1);
                if (index == _selected.value) {
                  _selected.value = -1;
                } else {
                  _selected.value = index;
                }
              }),
            ),
            ValueListenableBuilder(
                valueListenable: _selected,
                builder: ((context, int value, child) => Positioned(
                      child: SizedBox(
                        child: VerticalDivider(
                          color: value >= 0
                              ? CommonColors.primary2Color
                              : Colors.transparent,
                          thickness: 1,
                          width: 1,
                        ),
                        height: ScreenUtil().screenHeight / 3,
                      ),
                      left: max(0,
                          max(0, value + 0.5) * partW + cs.defaultMargin.left),
                    )))
          ],
        ),
      ],
    );
  }
}

class LineChart extends StatelessWidget {
  LineChart(
      {required this.sourceData,
      required this.secendData,
      required this.headerInfoBuild,
      required this.headerW,
      this.titleInfoBuild,
      this.dataAxisMax,
      this.dataAxisMin,
      this.hAxisStep = 10,
      this.vAxisStep = 1,
      this.vaTitle,
      Key? key})
      : super(key: key);
  ValueNotifier<int> _selected = ValueNotifier(-1);

  double itemW = 7;
  List<MyCandleItem> sourceData;
  List<MyCandleItem> secendData;
  Widget? Function(int) headerInfoBuild;
  double headerW;

  Widget Function()? titleInfoBuild;

  double? dataAxisMax; // 制表最大值
  double? dataAxisMin; // 制表最小值
  double hAxisStep; // 横坐标间距包含多少个单位数值
  double vAxisStep;
  List<String>? vaTitle;

  @override
  Widget build(BuildContext context) {
    double chartW = ScreenUtil().screenWidth - 40;

    var allData = sourceData + secendData;
    double dataMax =
        (allData.map((e) => e.max).reduce(math.max).truncateToDouble() ~/
                    hAxisStep +
                1) *
            hAxisStep;

    double dataMin =
        allData.map((e) => e.max).reduce(math.min).truncateToDouble();

    dataMax = dataAxisMax ?? dataMax;
    dataMin = dataAxisMin ?? dataMin;

    double leftPaddingX = dataMax >= 6 * 17 ? 27 : (dataMax >= 6 * 2 ? 20 : 14);
    double partW = (chartW - leftPaddingX) / sourceData.length;

    ChartState cs = ChartState(

        /// 折线图
        data: ChartData(
          [
            sourceData.map((e) => ChartItem<void>(e.max)).toList(),
            secendData.map((e) => ChartItem<void>(e.max)).toList(),
          ],
          axisMax: dataAxisMax,
          axisMin: dataAxisMin,
        ),
        itemOptions: BubbleItemOptions(
            minBarWidth: 6.0.w,
            maxBarWidth: 6.0.w,
            bubbleItemBuilder: (data) {
              return BubbleItem(
                color: Colors.white,
                border: BorderSide(
                  width: 1.w,
                  color:
                      (data.itemIndex == _selected.value || _selected.value < 0)
                          ? CommonColors.red
                          : CommonColors.red.withOpacity(0.4),
                ),
              );
            }),
        backgroundDecorations: [
          GridDecoration(
            horizontalLegendPosition: HorizontalLegendPosition.start,
            horizontalValuesPadding: EdgeInsets.only(right: 5.w),
            horizontalAxisValueFromValue: ((value) => '${value}'),
            verticalTextAlign: TextAlign.left,
            showHorizontalValues: true,
            horizontalAxisStep: hAxisStep,
            gridColor: Color.fromRGBO(181, 181, 181, 1),
            textStyle: TextStyle(
              fontSize: 12.sp,
              color: Color.fromRGBO(181, 181, 181, 1),
            ),
            showVerticalGrid: false,
          ),
          VerticalAxisDecoration(
            valueFromIndex: (index) => vaTitle?[index ~/ vAxisStep] ?? '$index',
            valuesPadding: EdgeInsets.only(top: 10, left: 2),
            showValues: true,
            valuesAlign: TextAlign.start,
            legendFontStyle: TextStyle(
              fontSize: 12.sp,
              color: Color.fromRGBO(181, 181, 181, 1),
            ),
            axisStep: vAxisStep,
            dashArray: [2, 4],
          ),
        ],
        foregroundDecorations: [
          SparkLineDecoration(
            lineWidth: 1,
            lineColor: Colors.black,
            listIndex: 0,
          ),
          SparkLineDecoration(
              lineWidth: 1,
              lineColor: Colors.black,
              listIndex: 1,
              dashArray: [5, 7]),
        ]);

    partW = (chartW - cs.defaultMargin.left) / sourceData.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder(
          valueListenable: _selected,
          builder: ((context, int selectedIndex, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (selectedIndex >= 0)
                  Container(
                    margin: EdgeInsets.only(
                      left: min(
                          max(
                              0,
                              ((selectedIndex + 0.5) * partW +
                                      cs.defaultMargin.left) -
                                  headerW / 2),
                          chartW - headerW),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: CommonColors.primaryColor,
                    ),
                    child: selectedIndex >= 0
                        ? headerInfoBuild(selectedIndex)
                        : null,
                  ),
                if (selectedIndex >= 0)
                  Container(
                    margin: EdgeInsets.only(
                      left:
                          (selectedIndex + 0.5) * partW + cs.defaultMargin.left,
                    ),
                    width: 1.w,
                    height: 17.5.h,
                    color: CommonColors.primary2Color,
                  ),
                if (selectedIndex < 0 && titleInfoBuild != null)
                  titleInfoBuild!(),
              ],
            );
          }),
        ),
        Stack(
          children: [
            GestureDetector(
              child: ValueListenableBuilder(
                valueListenable: _selected,
                builder: (c, v, p) => Chart(
                  height: ScreenUtil().screenHeight / 3,
                  width: chartW,
                  state: cs,
                ),
              ),
              behavior: HitTestBehavior.opaque,
              onPanUpdate: ((details) {
                var contentX = details.localPosition.dx - cs.defaultMargin.left;
                int index =
                    min((contentX / partW).truncate(), cs.data.listSize - 1);
                if (index != _selected.value) {
                  _selected.value = index;
                }
              }),
              onTapDown: ((details) {
                var contentX = details.localPosition.dx - cs.defaultMargin.left;
                int index =
                    min((contentX / partW).truncate(), cs.data.listSize - 1);
                if (index == _selected.value) {
                  _selected.value = -1;
                } else {
                  _selected.value = index;
                }
              }),
            ),
            ValueListenableBuilder(
                valueListenable: _selected,
                builder: ((context, int value, child) => Positioned(
                      child: SizedBox(
                        child: VerticalDivider(
                          color: value >= 0
                              ? CommonColors.primary2Color
                              : Colors.transparent,
                          thickness: 1.w,
                          width: 1.w,
                        ),
                        height: ScreenUtil().screenHeight / 3,
                      ),
                      left: max(0,
                          max(0, value + 0.5) * partW + cs.defaultMargin.left),
                    )))
          ],
        ),
      ],
    );
  }
}

class MyCandleItem {
  MyCandleItem(this.min, this.max, {this.title, this.creatTime});
  final double max;
  final double min;
  final String? title;
  final DateTime? creatTime;
}
