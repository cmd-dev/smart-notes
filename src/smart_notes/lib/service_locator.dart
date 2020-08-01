import 'package:smart_notes/view_models/view_models.dart';
import 'package:smart_notes/services/services.dart';
import 'package:smart_notes/views/views.dart';
import 'package:smart_notes_common/constants.dart';
import 'package:smart_notes_util/app_util.dart';
import 'package:smart_notes_data/caching.dart';
import 'package:smart_notes_data/database.dart';
import 'package:smart_notes_data/web_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_notes_business/managers.dart';
import 'package:smart_notes_business/mappers.dart';

class ServiceLocator {
  static bool configured = false;

  @protected
  static final i = GetIt.instance;

  static void configure() {
    assert(!configured);

    i
      // Register Views
      ..registerLazySingleton<AppView>(() => AppView(i.get<AppViewModel>()))
      ..registerFactory<Widget>(() => LoginView(i.get<LoginViewModel>()),
          instanceName: ViewNames.loginView)
      ..registerFactory<Widget>(() => HomeView(i.get<HomeViewModel>()),
          instanceName: ViewNames.homeView)
      ..registerFactory<Widget>(() => NoteView(i.get<NoteViewModel>()),
          instanceName: ViewNames.noteView)
      ..registerFactory<Widget>(() => SettingsView(i.get<SettingsViewModel>()),
          instanceName: ViewNames.settingsView)
      ..registerFactory<Widget>(() => TagsView(i.get<TagsViewModel>()),
          instanceName: ViewNames.tagsView)

      // Register View Models
      ..registerLazySingleton<AppViewModel>(() => AppViewModel(
            i.get<AuthManager>(),
            i.get<SettingsManager>(),
            i.get<AnalyticsService>(),
            i.get<NavigationService>(),
          ))
      ..registerFactory<LoginViewModel>(() => LoginViewModel(
            i.get<AuthManager>(),
            i.get<NavigationService>(),
            i.get<DialogService>(),
          ))
      ..registerFactory<HomeViewModel>(() => HomeViewModel(
            i.get<AccountManager>(),
            i.get<TagsManager>(),
            i.get<NotesManager>(),
            i.get<NavigationService>(),
            i.get<DialogService>(),
          ))
      ..registerFactory<NoteViewModel>(() => NoteViewModel(
            i.get<NotesManager>(),
            i.get<TagsManager>(),
            i.get<AccountManager>(),
            i.get<CameraService>(),
            i.get<MLVisionService>(),
            i.get<NavigationService>(),
            i.get<DialogService>(),
          ))
      ..registerFactory<SettingsViewModel>(() => SettingsViewModel(
            i.get<AuthManager>(),
            i.get<AccountManager>(),
            i.get<SettingsManager>(),
            i.get<NavigationService>(),
            i.get<DialogService>(),
          ))
      ..registerFactory<TagsViewModel>(() => TagsViewModel(
            i.get<TagsManager>(),
            i.get<AccountManager>(),
            i.get<NavigationService>(),
            i.get<DialogService>(),
          ))

      // Register Services
      ..registerLazySingleton<NavigationService>(() => NavigationServiceImpl())
      ..registerLazySingleton<DialogService>(() => DialogServiceImpl())
      ..registerLazySingleton<CameraService>(() => CameraServiceImpl())
      ..registerLazySingleton<MLVisionService>(() => MLVisionServiceImpl())

      // Register Managers
      ..registerLazySingleton<AuthManager>(() => AuthManagerImpl(
            i.get<AccountManager>(),
            i.get<AuthService>(),
            i.get<AccountMapper>(),
            i.get<KeyStoreService>(),
            i.get<AccountRepository>(),
          ))
      ..registerLazySingleton<AccountManager>(() => AccountManagerImpl())
      ..registerLazySingleton<SettingsManager>(() =>
          SettingsManagerImpl(i.get<CacheService>(), i.get<DriveService>()))
      ..registerLazySingleton<TagsManager>(
          () => TagsManagerImpl(i.get<TagsRepository>(), i.get<TagMapper>()))
      ..registerLazySingleton<NotesManager>(() => NotesManagerImpl(
            i.get<NotesRepository>(),
            i.get<NoteMapper>(),
            i.get<NoteWithTagMapper>(),
          ))

      // Register Mappers
      ..registerLazySingleton<GoogleAccountMapper>(
          () => GoogleAccountMapperImpl())
      ..registerLazySingleton<AccountMapper>(
          () => AccountMapperImpl(i.get<GoogleAccountMapper>()))
      ..registerLazySingleton<NoteMapper>(() => NoteMapperImpl())
      ..registerLazySingleton<NoteWithTagMapper>(
          () => NoteWithTagMapperImpl(i.get<TagMapper>()))
      ..registerLazySingleton<TagMapper>(() => TagMapperImpl())

      // Register Data
      ..registerLazySingleton<ENotesDatabase>(() => ENotesDatabase())
      ..registerLazySingleton<TagsRepository>(
          () => TagsRepository(i.get<ENotesDatabase>()))
      ..registerLazySingleton<AccountRepository>(
          () => AccountRepository(i.get<ENotesDatabase>()))
      ..registerLazySingleton<NotesRepository>(
          () => NotesRepository(i.get<ENotesDatabase>()))
      ..registerLazySingleton<CacheService>(() => CacheServiceImpl())
      ..registerLazySingleton<KeyStoreService>(() => KeyStoreServiceImpl())

      // Register Web
      ..registerLazySingleton<AuthService>(() => AuthServiceImpl())
      ..registerLazySingleton<DriveService>(() => DriveServiceImpl(
            i.get<KeyStoreService>(),
            i.get<NotesRepository>(),
            i.get<TagsRepository>(),
          ))

      // Register Utilities
      ..registerLazySingleton<AnalyticsService>(() => AnalyticsServiceImpl());

    configured = true;
  }

  static T resolve<T>() => i.get<T>();

  static T resolveNamed<T>(String name) => i.get(name) as T;
}
