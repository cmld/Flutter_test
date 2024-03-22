import 'package:clmd_flutter/components/swipe_list.dart';
import 'package:clmd_flutter/models/report.dart';
import 'package:clmd_flutter/utils/env.dart';
import 'package:clmd_flutter/utils/network.dart';
import 'package:flutter/material.dart';

class LrScorllScreen extends StatefulWidget {
  const LrScorllScreen({Key? key}) : super(key: key);

  @override
  _LrScorllScreenState createState() => _LrScorllScreenState();
}

class _LrScorllScreenState extends State<LrScorllScreen> {
  ValueNotifier<int> _type = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Env.current.name)),
      body: DecoratedBox(
        decoration:
            BoxDecoration(border: Border.all(width: 2, color: Colors.black)),
        child: Column(children: [
          ValueListenableBuilder(
            valueListenable: _type,
            builder: (c, v, p) => SwipeList(
              cWidth: 400,
              cHeight: 200,
              getData: (idx) => Future.delayed(Duration(seconds: 1))
                  .then((value) => idx.toString()),
              contentBuild: (data) => Container(
                color: Colors.red,
                child: Center(
                  child: Text(
                    data.toString(),
                    style: TextStyle(backgroundColor: Colors.yellow),
                  ),
                ),
              ),
              onCallCurrentData: (idx, data) {
                print('clmd call $data');
              },
            ),
          ),
          TextButton(
              onPressed: () {
                _type.value = _type.value + 1;
              },
              child: Text('change type')),
          TextButton(
              onPressed: () {
                (slKey.currentState as SwipeListState).scorllToIdx(10);
              },
              child: Text('to 0')),
          Row(
            children: [
              SizedBox(
                  width: 4343,
                  child: TextButton(
                    onPressed: () {
                      var dd = [''][2];
                    },
                    child: Text('error'),
                  )),
            ],
          )
        ]),
      ),
    );
  }
}
