import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:newclub/core/api_provider.dart';
import 'package:newclub/core/connection_checker.dart';
import 'package:newclub/core/hive_service.dart';
import 'package:newclub/data/remote/data_source/app_Data_Source.dart';
import 'package:newclub/domain/repositories/app_repositoryImpl.dart';
import 'package:newclub/domain/usecase/auth/LoginUseCase.dart';
import 'package:newclub/domain/usecase/cart/cartSaveUseCase.dart';
import 'package:newclub/domain/usecase/kot/kotItemsUseCase.dart';
import 'package:newclub/domain/usecase/memberOrGuest/locateCounterUseCase.dart';
import 'package:newclub/domain/usecase/memberOrGuest/locateWaitersUseCase.dart';
import 'package:newclub/domain/usecase/memberOrGuest/validateMemberUseCase.dart';

import 'data/repository/app_repository.dart';

final sl = GetIt.instance;

Future<void> setUp() async {
//core
  sl.registerLazySingleton<ApiProvider>(() => ApiProvider());
  sl.registerLazySingleton<HiveService>(() => HiveService());
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  sl.registerLazySingleton<ConnectionChecker>(
      () => ConnectionCheckerImpl(sl()));
  //data source
  sl.registerLazySingleton<AppDataSource>(() => AppDataSourceImpl(sl()));
  //repository
  sl.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(sl()));
  //usecase
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<LocateCounterUseCase>(
      () => LocateCounterUseCase(sl()));
  sl.registerLazySingleton<LocateWaiterUseCase>(
      () => LocateWaiterUseCase(sl()));
  sl.registerLazySingleton<ValidateMemberUseCase>(
      () => ValidateMemberUseCase(sl()));
  sl.registerLazySingleton<KotItemsUseCase>(() => KotItemsUseCase(sl()));
  sl.registerLazySingleton<CartSaveUseCase>(() => CartSaveUseCase(sl()));
}
