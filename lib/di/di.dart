import 'package:bizda_bor/core/platform/network_info.dart';
import 'package:bizda_bor/fuatures/auth/data/data_sources/login_local_datasource.dart';
import 'package:bizda_bor/fuatures/auth/data/data_sources/login_remote_data_source.dart';
import 'package:bizda_bor/fuatures/auth/data/models/user_model.dart';
import 'package:bizda_bor/fuatures/auth/data/repositories/auth_repository_impl.dart';
import 'package:bizda_bor/fuatures/auth/domain/repositories/auth_reppository.dart';
import 'package:bizda_bor/fuatures/auth/domain/use_cases/confirmSms_usescase.dart';
import 'package:bizda_bor/fuatures/auth/domain/use_cases/login_usescase.dart';
import 'package:bizda_bor/fuatures/auth/domain/use_cases/register_usescase.dart';
import 'package:bizda_bor/fuatures/auth/presentation/manager/auth_bloc.dart';
import 'package:bizda_bor/fuatures/cart/data/data_sources/card_remote_datasource.dart';
import 'package:bizda_bor/fuatures/cart/data/repositories/cards_repository_impl.dart';
import 'package:bizda_bor/fuatures/cart/domain/repositories/cards_repository.dart';
import 'package:bizda_bor/fuatures/cart/domain/use_cases/create_location_usescase.dart';
import 'package:bizda_bor/fuatures/cart/domain/use_cases/create_order_usescase.dart';
import 'package:bizda_bor/fuatures/cart/domain/use_cases/delete_card_usescase.dart';
import 'package:bizda_bor/fuatures/cart/domain/use_cases/get_cards_usescase.dart';
import 'package:bizda_bor/fuatures/cart/domain/use_cases/update_card_usescase.dart';
import 'package:bizda_bor/fuatures/cart/presentation/manager/cards_bloc.dart';
import 'package:bizda_bor/fuatures/category_detail/data/datasourse/category_section_remote_datasourse.dart';
import 'package:bizda_bor/fuatures/category_detail/data/repository/category_section_repository_impl.dart';
import 'package:bizda_bor/fuatures/category_detail/domain/repository/category_section_repository.dart';
import 'package:bizda_bor/fuatures/category_detail/domain/usecase/get_all_child_sections_usecase.dart';
import 'package:bizda_bor/fuatures/category_detail/domain/usecase/get_all_sections_usecase.dart';
import 'package:bizda_bor/fuatures/category_detail/presentation/bloc/bloc/category_section_bloc.dart';
import 'package:bizda_bor/fuatures/favourites/data/data_sources/favourites_remote_datasourse.dart';
import 'package:bizda_bor/fuatures/favourites/data/repositories/favourites_repository_impl.dart';
import 'package:bizda_bor/fuatures/favourites/domain/repositories/favourites_repository.dart';
import 'package:bizda_bor/fuatures/favourites/domain/use_cases/create_favourite_usescase.dart';
import 'package:bizda_bor/fuatures/favourites/domain/use_cases/delete_favourite_usescase.dart';
import 'package:bizda_bor/fuatures/favourites/domain/use_cases/get_favourites_usescase.dart';
import 'package:bizda_bor/fuatures/favourites/presentation/manager/favourites_bloc.dart';
import 'package:bizda_bor/fuatures/main/data/datasourse/category_remote_datasourse.dart';
import 'package:bizda_bor/fuatures/main/data/repository/categories_repository_impl.dart';
import 'package:bizda_bor/fuatures/main/domain/repository/categories_repository.dart';
import 'package:bizda_bor/fuatures/main/domain/use_cse/get_all_categories_use_case.dart';
import 'package:bizda_bor/fuatures/main/domain/use_cse/get_banners_use_case.dart';
import 'package:bizda_bor/fuatures/main/presentation/bloc/category/category_bloc.dart';
import 'package:bizda_bor/fuatures/product_detail/data/datasourse/pr_detail_remote_datasourse.dart';
import 'package:bizda_bor/fuatures/product_detail/data/repository/pr_detail_repository_impl.dart';
import 'package:bizda_bor/fuatures/product_detail/domain/repository/pr_detail_repository.dart';
import 'package:bizda_bor/fuatures/product_detail/domain/use_cse/add_to_card_usescase.dart';
import 'package:bizda_bor/fuatures/product_detail/domain/use_cse/pr_detail_usescase.dart';
import 'package:bizda_bor/fuatures/product_detail/presentation/manager/pr_detail_bloc.dart';
import 'package:bizda_bor/fuatures/profile/data/data_sources/orders_remote_datasource.dart';
import 'package:bizda_bor/fuatures/profile/data/repositories/orders_repository_impl.dart';
import 'package:bizda_bor/fuatures/profile/domain/repositories/order_repository.dart';
import 'package:bizda_bor/fuatures/profile/domain/use_cases/get_orders_usescase.dart';
import 'package:bizda_bor/fuatures/profile/presentation/manager/orders_bloc.dart';
import 'package:bizda_bor/fuatures/search/data/data_sources/search_remote_data_source.dart';
import 'package:bizda_bor/fuatures/search/data/repositories/search_repository_impl.dart';
import 'package:bizda_bor/fuatures/search/domain/repositories/search_reppository.dart';
import 'package:bizda_bor/fuatures/search/domain/use_cases/search_usescase.dart';
import 'package:bizda_bor/fuatures/search/presentation/manager/search_bloc.dart';
import 'package:bizda_bor/services/get_products/data/data_sources/get_product_remote_data_source.dart';
import 'package:bizda_bor/services/get_products/data/repositories/get_product_repository_impl.dart';
import 'package:bizda_bor/services/get_products/domain/repositories/get_product_repository.dart';
import 'package:bizda_bor/services/get_products/domain/use_cases/get_product_usescase.dart';
import 'package:bizda_bor/services/get_products/domain/use_cases/get_random_product_usescase.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final di = GetIt.instance;

Future<void> init() async {
  /// Local datasource

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  di.registerLazySingleton(() => sharedPreferences);

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter<UserModel>(UserModelAdapter());
    await Hive.openBox(UserModel.boxKey);
  }
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter<UserData>(UserDataAdapter());
    await Hive.openBox(UserData.boxKey);
  }

//! DataSource
  di.registerLazySingleton<AuthLocalDataSourceImpl>(
      () => AuthLocalDataSourceImpl());

  di.registerLazySingleton<AuthRemoteDataSourceImpl>(
      () => AuthRemoteDataSourceImpl(dio: di()));

  di.registerLazySingleton<CategoriesRemoteDataSourse>(
      () => CategoriesRemoteDataSourseImpl(dio: di()));
  di.registerLazySingleton<CategorySectionRemoteDataSourse>(
      () => CategorySectionRemoteDataSourseImpl(dio: di()));

  di.registerLazySingleton<SearchRemoteDataSourceImpl>(
      () => SearchRemoteDataSourceImpl(dio: di()));
  di.registerLazySingleton<PrDetailRemoteDataSourseImpl>(
      () => PrDetailRemoteDataSourseImpl(dio: di()));
  di.registerLazySingleton<GetProductRemoteDataSourceImpl>(
      () => GetProductRemoteDataSourceImpl(dio: di()));

  di.registerLazySingleton<CardRemoteDatasourse>(
      () => CardRemoteDatasourseImpl(dio: di()));

  di.registerLazySingleton<FavouritesRemoteDataSource>(
      () => FavouritesRemoteDataSourceImpl(dio: di()));

  di.registerLazySingleton<OrdersRemoteDataSource>(
      () => OrdersRemoteDataSourceImpl(dio: di()));

//!Repository
  di.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      remoteDataSourceImpl: di(),
      networkInfo: di(),
      localDataSourceImpl: di()));

  di.registerLazySingleton<CategoriesRepository>(() => CategoriesRepositoryImpl(
      categoriesRemoteDataSourse: di(), networkInfo: di()));

  di.registerLazySingleton<CategorySectionRepository>(() =>
      CategorySectionRepositoryImpl(
          categorySectionRemoteDataSourse: di(), networkInfo: di()));

  di.registerLazySingleton<SearchRepository>(() =>
      SearchRepositoryImpl(remoteDataSourceImpl: di(), networkInfo: di()));

  di.registerLazySingleton<PrDetailRepository>(() => PrDetailRepositoryImpl(
      prDetailRemoteDataSourse: di(), networkInfo: di()));

  di.registerLazySingleton<GetProductRepository>(() =>
      GetProductRepositoryImpl(remoteDataSourceImpl: di(), networkInfo: di()));

  di.registerLazySingleton<CardsRepository>(() =>
      CardsRepositoryImpl(cardsRemoteDataSource: di(), networkInfo: di()));

  di.registerLazySingleton<FavouritesRepository>(() =>
      FavouritesRepositoryImpl(remoteDataSource: di(), networkInfo: di()));

  di.registerLazySingleton<OrdersRepository>(() =>
      OrdersRepositoryImpl(ordersRemoteDataSource: di(), networkInfo: di()));

//!Bloc
  di.registerFactory(() => AuthBloc(
      loginUsesCase: di(), confirmSmsUsesCase: di(), registerUsesCase: di()));
  di.registerFactory(() => CategoryBloc(
        getAllCategoriesUseCase: di(),
        getProductUsesCase: di(),
        getBannersUseCase: di(),
        updateCardsUsesCase: di(),
        createFavUsescase: di(),
        deleteFavUsescase: di(),
        addToCardUseCase: di(),
      ));
  di.registerFactory(
    () => CategorySectionBloc(
      getAllSectionsUsecase: di(),
      getProductUsesCase: di(),
      childSectionsUsecase: di(),
    ),
  );
  di.registerFactory(
      () => SearchBloc(searchUsesCase: di(), getAllCategoriesUseCase: di()));

  di.registerFactory(
    () => PrDetailBloc(
      prDetailUseCase: di(),
      addToCardUseCase: di(),
      updateCardsUsesCase: di(),
      deleteFavouriteUsescase: di(),
      getProductUsesCase: di(),
    ),
  );
  di.registerFactory(
    () => CardsBloc(
      deleteCardsUsesCase: di(),
      createOrderUsesCase: di(),
      createLocationUsesCase: di(),
      updateCardsUsesCase: di(),
      getCardsUsesCase: di(),
    ),
  );
  di.registerFactory(
    () => FavouritesBloc(
      getFavUsescase: di(),
      deleteFavouriteUsescase: di(),
      updateCardsUsesCase: di(),
    ),
  );
  di.registerFactory(
    () => OrdersBloc(getOrdersUsesCase: di()),
  );

//UseCase
  di.registerLazySingleton(() => LoginUsesCase(repository: di()));
  di.registerLazySingleton(() => SearchUsesCase(repository: di()));
  di.registerLazySingleton(() => ConfirmSmsUsesCase(repository: di()));
  di.registerLazySingleton(() => GetBannersUseCase(repository: di()));
  di.registerLazySingleton(
      () => GetAllCategoriesUseCase(categoriesRepository: di()));

  di.registerLazySingleton(
      () => GetAllSectionsUsecase(categorySectionRepository: di()));

  di.registerLazySingleton(() => RegisterUsesCase(repository: di()));
  di.registerLazySingleton(() => PrDetailUseCase(categoriesRepository: di()));
  di.registerLazySingleton(() => GetRandomProductUsesCase(repository: di()));
  di.registerLazySingleton(() => GetProductUsesCase(repository: di()));
  di.registerLazySingleton(() => GetAllChildSectionsUsecase(repository: di()));
  di.registerLazySingleton(() => AddToCardUseCase(repository: di()));
  di.registerLazySingleton(() => GetCardsUsesCase(repository: di()));
  di.registerLazySingleton(() => UpdateCardsUsesCase(repository: di()));
  di.registerLazySingleton(() => DeleteCardsUsesCase(repository: di()));
  di.registerLazySingleton(() => DeleteFavouriteUsescase(repository: di()));
  di.registerLazySingleton(() => CreateFavouriteUsescase(repository: di()));
  di.registerLazySingleton(() => GetFavouritesUsescase(repository: di()));
  di.registerLazySingleton(() => GetOrdersUsesCase(repository: di()));
  di.registerLazySingleton(() => CreateLocationUsesCase(repository: di()));
  di.registerLazySingleton(() => CreateOrderUsesCase(repository: di()));

  /// Network
  final options = BaseOptions(
      baseUrl: 'https://jalolxon002.pythonanywhere.com/api',
      // baseUrl: 'https://bizda-bor.uz/api',
      connectTimeout: const Duration(seconds: 50),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'accept': 'application/json'
      });

  Dio dio = Dio(options);
  dio.interceptors.add(LogInterceptor());

  di.registerSingleton<Dio>(dio);
  di.registerLazySingleton(() => http.Client());

  /// Network Info
  di.registerLazySingleton(() => InternetConnectionChecker());

  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(di()));
}
