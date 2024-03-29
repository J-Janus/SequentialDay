import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_wear_app/buttonStyler.dart/standardButtonStyle.dart';
import 'package:my_wear_app/watch/counter.dart';
import 'package:my_wear_app/l10n/l10n.dart';
import 'package:my_wear_app/watch/cubit/button_view_cubit.dart';
import 'package:my_wear_app/watch/cubit/task_cubit.dart';
import 'package:my_wear_app/watch/cubit/timer_cubit.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:wearable_rotary/wearable_rotary.dart' as wearable_rotary
    show rotaryEvents;
import 'package:wearable_rotary/wearable_rotary.dart' hide rotaryEvents;
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class WatchPage extends StatefulWidget {
  const WatchPage({super.key});

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  final controller = SwiperController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<TimerCubit>(
            create: (context) => TimerCubit(),
          ),
          BlocProvider<TaskCubit>(
            create: (context) => TaskCubit(),
          ),
          BlocProvider<ButtonViewCubit>(
            create: (context) => ButtonViewCubit(),
          )
        ],
        child: BlocBuilder<TaskCubit, List<String>>(
          builder: (context, state) {
            return state.isEmpty
                ? CircularProgressIndicator.adaptive()
                : Swiper(
                    itemCount: state.length,
                    controller: controller,
                    itemBuilder: (BuildContext context, int index) {
                      return CounterView(
                          key: ValueKey(index),
                          controller: controller,
                          task: state[index]);
                    },
                    pagination: SwiperPagination(),
                    control: SwiperControl());
          },
        ));
  }
}

class CounterView extends StatefulWidget {
  CounterView(
      {super.key,
      @visibleForTesting Stream<RotaryEvent>? rotaryEvents,
      required this.controller,
      required this.task})
      : rotaryEvents = rotaryEvents ?? wearable_rotary.rotaryEvents;

  final Stream<RotaryEvent> rotaryEvents;
  final SwiperController controller;
  final String task;

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  late final StreamSubscription<RotaryEvent> rotarySubscription;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  late TaskCubit task_provider;
  

  @override
  void initState() {
    super.initState();
    task_provider = context.read<TaskCubit>();
    rotarySubscription = widget.rotaryEvents.listen(handleRotaryEvent);
  }

  @override
  void dispose() {
    rotarySubscription.cancel();
    super.dispose();
    _stopWatchTimer.dispose();
  }

  void handleRotaryEvent(RotaryEvent event) {
    if (event.direction == RotaryDirection.clockwise) {
      widget.controller.next(animation: true);
    } else {
      widget.controller.previous(animation: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
              },
              child: Text("task name"),
            ),
            const SizedBox(height: 20),
            BlocBuilder<TimerCubit, String>(
              builder: (context, state) {
                return Text(state);
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<ButtonViewCubit, ButtonView>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state == ButtonView.start)
                      ElevatedButton(
                          onPressed: () {
                            context.read<TimerCubit>().start();
                          },
                          style: myButtonStyle,
                          child: const Icon(Icons.play_arrow)),
                    if (state == ButtonView.stop)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                context.read<TimerCubit>().stop();
                              },
                              onLongPress: () {
                                context.read<TimerCubit>().restart();
                              },
                              style: myButtonStyle,
                              child: const Icon(Icons.pause)),
                          const SizedBox(width: 10),
                          ElevatedButton(
                              onPressed: () {
                                context.read<TimerCubit>().complete_task("taks_id", "task_content");
                              },
                              style: myButtonStyle,
                              child: const Icon(Icons.save))
                        ],
                      )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

