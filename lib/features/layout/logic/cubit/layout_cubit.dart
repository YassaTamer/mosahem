import 'package:flutter_bloc/flutter_bloc.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutState(0));

  void changeTab(int index) {
    emit(LayoutState(index));
  }
}
