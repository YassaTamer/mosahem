import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutState(0));

  void changeTab(int index) {
    emit(LayoutState(index));
  }
}
