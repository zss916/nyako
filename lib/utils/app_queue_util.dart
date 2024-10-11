import 'dart:async';

/// https://github.com/qq326646683/tech-article/blob/master/flutter/Flutter%E4%B8%8A%E7%BA%BF%E9%A1%B9%E7%9B%AE%E5%AE%9E%E6%88%98%E2%80%94%E2%80%94%E9%98%9F%E5%88%97%E4%BB%BB%E5%8A%A1.md

class AppQueueUtil {
  /// 用map key存储多个QueueUtil单例,目的是隔离多个类型队列任务互不干扰
  /// Use map key to store multiple QueueUtil singletons, the purpose is to isolate multiple types of queue tasks without interfering with each other
  static Map<String, AppQueueUtil> _instance = Map<String, AppQueueUtil>();

  static AppQueueUtil? get(String key) {
    if (_instance[key] == null) {
      _instance[key] = AppQueueUtil._();
    }
    return _instance[key];
  }

  AppQueueUtil._() {
    /// 初始化代码
  }

  List<_YuliaTaskInfo> _taskList = [];
  bool _isTaskRunning = false;
  int _mId = 0;
  bool _isCancelQueue = false;

  /// 发现这个doSomething得是async方法，且里面有await
  Future<_YuliaTaskInfo> addTask(Function doSomething) {
    _isCancelQueue = false;
    _mId++;
    _YuliaTaskInfo taskInfo = _YuliaTaskInfo(_mId, doSomething);

    /// 创建future
    Completer<_YuliaTaskInfo> taskCompleter = Completer<_YuliaTaskInfo>();

    /// 创建当前任务stream
    StreamController<_YuliaTaskInfo> streamController = new StreamController();
    taskInfo.controller = streamController;

    /// 添加到任务队列
    _taskList.add(taskInfo);

    /// 当前任务的stream添加监听
    streamController.stream.listen((_YuliaTaskInfo completeTaskInfo) {
      if (completeTaskInfo.id == taskInfo.id) {
        taskCompleter.complete(completeTaskInfo);
        streamController.close();
      }
    });

    /// 触发任务
    _doTask();

    return taskCompleter.future;
  }

  void cancelTask() {
    _taskList = [];
    _isCancelQueue = true;
    _mId = 0;
    _isTaskRunning = false;
  }

  _doTask() async {
    if (_isTaskRunning) return;
    if (_taskList.isEmpty) return;

    /// 取任务
    _YuliaTaskInfo taskInfo = _taskList[0];
    _isTaskRunning = true;
    // AppLog.debug('AppQueueUtil _isTaskRunning size=${_taskList.length}');

    /// 模拟执行任务
    await taskInfo.doSomething?.call();
    // AppLog.debug('AppQueueUtil doSomething id=${taskInfo.id}');
    taskInfo.controller?.sink.add(taskInfo);

    if (_isCancelQueue) return;

    /// 出队列
    _taskList.removeAt(0);
    _isTaskRunning = false;

    /// 递归执行任务
    _doTask();
  }
}

class _YuliaTaskInfo {
  int id; // 任务唯一标识
  Function? doSomething;
  StreamController<_YuliaTaskInfo>? controller;

  _YuliaTaskInfo(this.id, this.doSomething, {this.controller});
}
