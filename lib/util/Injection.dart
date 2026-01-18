import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:get_it/get_it.dart';

import '../my_repository/auth_repo/AuthRepo.dart';
import '../my_repository/home_repo/HomeRepo.dart';
import '../my_repository/profileRepo/ProfileRepo.dart';
import '../network/ApiService.dart';
import '../network/WebService.dart';
import 'ColorConst.dart';
import 'CommonFunction.dart';
import 'CommonWidget.dart';
import 'ConstValue.dart';
import 'ImageConst.dart';
import 'RouteHelper.dart';
import 'StringConst.dart';
import 'local_storage.dart';

final DI = GetIt.instance;

void setup() {
  DI.registerLazySingleton<RouteHelper>(() => RouteHelper());
  DI.registerLazySingleton<ImageConst>(() => ImageConst());
  DI.registerLazySingleton<ColorConst>(() => ColorConst());
  DI.registerLazySingleton<CommonFunction>(() => CommonFunction());
  DI.registerLazySingleton<CommonWidget>(() => CommonWidget());
  DI.registerLazySingleton<MyLocalStorage>(() => MyLocalStorage());
  DI.registerLazySingleton<Debouncer>(() => Debouncer());
  DI.registerLazySingleton<StringConst>(() => StringConst());

  DI.registerLazySingleton<ConstValue>(() => ConstValue());
  DI.registerLazySingleton<WebService>(() => WebService());
  DI.registerLazySingleton<ApiService>(() => ApiService());
  DI.registerLazySingleton<AuthRepo>(() => AuthRepo());
  DI.registerLazySingleton<ProfileRepo>(() => ProfileRepo());
  DI.registerLazySingleton<HomeRepo>(() => HomeRepo());

}


