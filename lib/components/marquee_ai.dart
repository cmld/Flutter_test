import 'package:flutter/material.dart';

class MarqueeWidget extends StatefulWidget {
  final String text; // 要滚动的文本
  final double width; // 组件宽度
  final double height; // 组件高度
  final TextStyle style; // 文字样式
  final int speed; // 滚动速度

  MarqueeWidget({
    required this.text,
    required this.width,
    required this.height,
    required this.style,
    required this.speed,
  });

  @override
  State<StatefulWidget> createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: widget.speed), vsync: this)
      ..repeat();
    _animation = Tween<Offset>(begin: Offset.zero, end: Offset(-1.0, 0.0))
        .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ClipRect(
        child: Align(
          alignment: Alignment.centerLeft,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget? child) {
              return FractionalTranslation(
                translation: _animation.value,
                child: Text(
                  widget.text,
                  style: widget.style,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
