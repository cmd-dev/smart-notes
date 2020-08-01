import 'package:smart_notes/keys/widget_keys.dart';
import 'package:smart_notes/resources/resources.dart';
import 'package:smart_notes/view_models/view_models.dart';
import 'package:smart_notes/widgets/widgets.dart';
import 'package:smart_notes_business/entities.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AppView extends ModelBoundWidget<AppViewModel> {
  AppView(AppViewModel viewModel) : super(viewModel, key: AppViewKeys.view);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends ModelBoundState<AppView, AppViewModel> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<AppViewModel>(
        builder: (context, child, viewModel) => _buildApp(),
      ),
    );
  }

  Widget _buildApp() {
    final effectiveTheme = viewModel.settings.themeConfig == ThemeConfig.dark
        ? ThemeMode.dark
        : ThemeMode.light;

    return MaterialApp(
      title: 'Smart Notes',
      debugShowCheckedModeBanner: false,
      themeMode: effectiveTheme,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      navigatorKey: AppViewKeys.navigator,
      home: const SplashWidget(),
      builder: (_, widget) => Navigator(
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (_) => DialogManagerWidget(child: widget),
        ),
      ),
    );
  }
}
