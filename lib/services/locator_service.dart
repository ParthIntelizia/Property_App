import 'package:get_it/get_it.dart';

import '../providers/navbar_provider.dart';
import 'navigation_service.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  Stopwatch stopwatch = Stopwatch()..start();
  locator.registerLazySingleton(() => NavigationService());
  locator.registerSingleton<NavBarIndex>(NavBarIndex());
  stopwatch.stop();
}
