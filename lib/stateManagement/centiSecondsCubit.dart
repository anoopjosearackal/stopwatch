import 'package:bloc/bloc.dart';

class CentiSecondsCubit extends Cubit<int> {

  CentiSecondsCubit() : super(0);

  void increment() => emit(state + 1);

  void reset() => emit(0);
}