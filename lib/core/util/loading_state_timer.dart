import 'dart:async';

typedef Emitter<T> = void Function(T state);

Timer loadingStateTimer<T>(
  Emitter<T> emit,
  Timer? timer,
  int loadingTimeElapsed,
  T Function(int?) loadingState,
) {
  loadingTimeElapsed = 0;
  timer?.cancel();

  emit(loadingState(null));

  return Timer.periodic(const Duration(seconds: 1), (t) {
    loadingTimeElapsed++;
    if (loadingTimeElapsed > 3) {
      emit(loadingState(loadingTimeElapsed));
      t.cancel();
    }
  });
}
