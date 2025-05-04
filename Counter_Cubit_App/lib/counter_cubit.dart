import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/counter_state.dart';

// type of state ? what does this cubit return?
class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState());
  int teamAPoints = 0;
  int teamBPoints = 0;
  void addPoints(int type, int points) {
    type == 1
        ? {teamAPoints += points, emit(counterAIncrementState())}
        : {teamBPoints += points, emit(counterBIncrementState())};
  }
}
