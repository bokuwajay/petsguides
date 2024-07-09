import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petsguides/app.dart';
import 'package:petsguides/core/util/observer.dart';
import 'package:petsguides/injection_container.dart';

void main() async {
  if (kDebugMode) {
    await dotenv.load(fileName: 'assets/env/.env.development');
  } else {
    await dotenv.load(fileName: 'assets/env/.env.production');
  }

  WidgetsFlutterBinding.ensureInitialized();

  // init Hive Local storage , create table (open box) and temporary database directory
  await Future.wait([
    Hive.initFlutter(),
    getTemporaryDirectory().then((path) async {
      HydratedBloc.storage = await HydratedStorage.build(storageDirectory: path);
    })
  ]);

  // register outside/ global instance / dependency
  await initializeDependencies();

// init this to observe the App state changes
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}
