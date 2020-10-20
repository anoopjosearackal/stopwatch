import 'package:bloc/bloc.dart';

class SecondsCubit extends Cubit<int> {

  SecondsCubit() : super(0);

  void increment() => emit(state + 1);

  void reset() => emit(0);
}