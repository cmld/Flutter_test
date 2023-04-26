import 'package:flutter/material.dart';

class ManageMultipleSwitch extends StatefulWidget {
  const ManageMultipleSwitch(this.itemTitle,
      {required this.onCallBack, this.initIndex, Key? key})
      : super(key: key);
  final List<String> itemTitle;
  final int? initIndex;
  final Function(int) onCallBack;
  @override
  _ManageMultipleSwitchState createState() => _ManageMultipleSwitchState();
}

class _ManageMultipleSwitchState extends State<ManageMultipleSwitch> {
  int _selected = 0;

  @override
  void initState() {
    super.initState();
    _selected = widget.initIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
            List.generate(widget.itemTitle.length, (value) => value).map((e) {
          return Expanded(
            flex: 1,
            child: Container(
              height: 37,
              decoration: e == _selected
                  ? BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(6),
                    )
                  : null,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _selected = e;
                  });
                  widget.onCallBack(e);
                },
                child: Text(
                  widget.itemTitle[e],
                  style: TextStyle(
                      fontSize: 16,
                      color: e == _selected
                          ? const Color.fromRGBO(255, 255, 255, 1)
                          : const Color.fromRGBO(70, 70, 70, 1)),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
