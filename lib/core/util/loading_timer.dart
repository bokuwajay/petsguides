import 'dart:async';

typedef Emitter<T> = void Function(T state);

void loadingTimer<T>(
  Emitter<T> emit,
  Timer? timer,
  int loadingTimeElapsed,
  T Function(int?) loadingState,
) async {
  loadingTimeElapsed = 0;
  timer?.cancel();

  emit(loadingState(null));

  timer = Timer.periodic(const Duration(seconds: 1), (t) async {
    loadingTimeElapsed++;
    if (loadingTimeElapsed > 3) {
      emit(loadingState(loadingTimeElapsed));
      t.cancel();
    }
  });
}
