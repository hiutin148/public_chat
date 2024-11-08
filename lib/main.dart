import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:public_chat/features/genai_setting/bloc/genai_bloc.dart';
import 'package:public_chat/features/login/ui/login_screen.dart';
import 'package:public_chat/features/splash/splash_screen.dart';
import 'package:public_chat/firebase_options.dart';
import 'package:public_chat/service_locator/service_locator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '_shared/bloc/localization_manager/localization_manager_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ServiceLocator.instance.initialise();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GenaiBloc>(
          create: (context) => GenaiBloc(),
        ),
        BlocProvider<LocalizationManagerCubit>(
          create: (context) => LocalizationManagerCubit()..loadSavedLocale(),
        ),
      ],
      child: BlocBuilder<LocalizationManagerCubit, LocalizationManagerState>(
        builder: (context, state) => MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: state.locale,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
