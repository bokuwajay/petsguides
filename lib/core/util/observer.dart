import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguides/core/util/logger.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e(error);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    logger.d('current state: ${change.currentState}');
    logger.d('next state: ${change.nextState}');
    super.onChange(bloc, change);
  }
}
