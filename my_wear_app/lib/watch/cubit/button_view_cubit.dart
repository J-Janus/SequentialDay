import 'package:flutter_bloc/flutter_bloc.dart';

enum ButtonView {
  start,
  stop,
  restart
}

class ButtonViewCubit extends Cubit<ButtonView> {
  ButtonViewCubit() : super(ButtonView.start);

  void start() => emit(ButtonView.start);
  void stop() => emit(ButtonView.stop);
  void restart() => emit(ButtonView.restart);
}