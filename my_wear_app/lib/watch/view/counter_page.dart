import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_wear_app/watch/counter.dart';
import 'package:my_wear_app/l10n/l10n.dart';
import 'package:wearable_rotary/wearable_rotary.dart' as wearable_rotary
    show rotaryEvents;
import 'package:wearable_rotary/wearable_rotary.dart' hide rotaryEvents;
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
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
    return Swiper(
                    itemCount: 1,
                    controller: controller,
                    itemBuilder: (BuildContext context, int index) {
                      return CounterView(
                          key: ValueKey(index),
                          controller: controller); // Każdy ekran z własnym CounterPage i kluczem
                    },
                    pagination: SwiperPagination(),
                    control: SwiperControl());
  }
}

class CounterView extends StatefulWidget {
  CounterView(
      {super.key,
      @visibleForTesting Stream<RotaryEvent>? rotaryEvents,
      required this.controller})
      : rotaryEvents = rotaryEvents ?? wearable_rotary.rotaryEvents;

  final Stream<RotaryEvent> rotaryEvents;
  final SwiperController controller;

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  late final StreamSubscription<RotaryEvent> rotarySubscription;

  @override
  void initState() {
    super.initState();
    rotarySubscription = widget.rotaryEvents.listen(handleRotaryEvent);
  }

  @override
  void dispose() {
    rotarySubscription.cancel();
    super.dispose();
  }

  void handleRotaryEvent(RotaryEvent event) {
    final cubit = context.read<CounterCubit>();
    if (event.direction == RotaryDirection.clockwise) {
      cubit.increment();
    } else {
      cubit.decrement();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.read<CounterCubit>().increment(),
              child: const Icon(Icons.add),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(l10n.counterAppBarTitle),
            const CounterText(),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.read<CounterCubit>().decrement(),
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((CounterCubit cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.displayMedium);
  }
}
