import 'dart:math';

import 'package:flutter/material.dart';

GlobalKey slKey = GlobalKey();

class SwipeList extends StatefulWidget {
  SwipeList({
    required this.cWidth,
    required this.cHeight,
    required this.getData,
    required this.contentBuild,
    required this.onCallCurrentData,
    this.cGap = 50,
    Key? key,
  }) : super(key: slKey);

  final double cWidth;
  final double cHeight;

  Future<dynamic> Function(int) getData;
  Widget Function(dynamic) contentBuild;
  Function(int, dynamic) onCallCurrentData;

  final double cGap;

  @override
  SwipeListState createState() => SwipeListState();
}

class SwipeListState extends State<SwipeList> {
  final ScrollController _ctrl = ScrollController();
  int _index = 0;

  List<dynamic> _cache = [];

  void scorllToIdx(int idx) {
    _index = idx;
    _ctrl.animateTo(max(0, idx) * widget.cWidth,
        duration: const Duration(milliseconds: 150), curve: Curves.bounceOut);
    if (_cache.length > idx) {
      widget.onCallCurrentData(idx, _cache[idx]);
    }
  }

  @override
  Widget build(BuildContext context) {
    _cache = [];
    _index = 0;
    return Listener(
      child: SizedBox(
        width: widget.cWidth,
        height: widget.cHeight,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          reverse: true,
          controller: _ctrl,
          scrollDirection: Axis.horizontal,
          itemBuilder: (c, index) {
            return SizedBox(
              width: widget.cWidth,
              height: widget.cHeight,
              child: FutureBuilder(
                future: Future(() async {
                  if (_cache.length > index) {
                    return _cache[index];
                  }

                  var result = await widget.getData(index);

                  if (_cache.length >= index) {
                    _cache.insert(index, result);
                  } else {
                    _cache.add(result);
                  }

                  return result;
                }),
                builder: (c, snp) {
                  switch (snp.connectionState) {
                    case ConnectionState.none:
                      return const Center(child: Icon(Icons.error));
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      if (_index == index && _cache.length > _index) {
                        Future(() =>
                            widget.onCallCurrentData(_index, _cache[_index]));
                      }
                      return widget.contentBuild(snp.requireData);
                  }
                },
              ),
            );
          },
        ),
      ),
      onPointerUp: (event) {
        if (_ctrl.offset > _index * widget.cWidth + widget.cGap) {
          _index += 1;
        } else if (_ctrl.offset < _index * widget.cWidth - widget.cGap) {
          _index -= 1;
        }

        if (_cache.length > _index) {
          widget.onCallCurrentData(max(0, _index), _cache[max(0, _index)]);
        }

        _ctrl.animateTo(max(0, _index) * widget.cWidth,
            duration: const Duration(milliseconds: 150),
            curve: Curves.bounceOut);
      },
    );
  }
}
