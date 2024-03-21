import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimerCubit extends Cubit<String> {
  TimerCubit() : super("00:00:00.00");

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final _isHours = true;
  DateTime _timeNow = DateTime.now();

  void start() {
    _stopWatchTimer.onStartTimer();
    _timeNow = DateTime.now();
    final value = _stopWatchTimer.rawTime.listen((event) {
      final displayTime = StopWatchTimer.getDisplayTime(event, hours: _isHours);
      emit(displayTime);
    });
  }

  void stop() {
    _stopWatchTimer.onStopTimer();
  }

  void restart() {
    _stopWatchTimer.onResetTimer();
  }

  void complete_task(String task, String content){
    
  }


}
