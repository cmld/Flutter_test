/// 一个将异步任务放入一个串行的队列中依次执行的工具
/// 可以在上个任务执行完成后插入间隔时间

import 'dart:async';

class SyncUtil {
  static List<Future? Function()> funcList = [];
  static Future? Function()? _currentFunc;

  static syncCall(Future? Function() futureFunc,
      {Duration space = Duration.zero}) {
    nextFunc() {
      funcList.removeAt(0);
      if (funcList.isNotEmpty) {
        _currentFunc = funcList.first;
        _currentFunc?.call();
      } else {
        _currentFunc = null;
      }
    }

    item() async {
      await futureFunc.call();
      if (space != Duration.zero) {
        return Future.delayed(space).then((_) => nextFunc());
      } else {
        return nextFunc();
      }
    }

    funcList.add(item);

    // 启动条件
    if (_currentFunc == null) {
      _currentFunc = funcList.first;
      _currentFunc?.call();
    }
  }
}
