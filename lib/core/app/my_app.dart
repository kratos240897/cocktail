import 'package:cocktail/core/init/theme/theme_bloc.dart';
import 'package:evolvex_lib/evolvex_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../base/service_locator.dart';
import '../init/routes/router.dart';
import '../init/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        builder: (context, child) {
          return BlocProvider(
            create: (context) => ThemeBloc(),
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Cocktail',
                  theme: ThemeData(
                      primarySwatch: state is ChangeThemeState ? state.color : Styles.colors.kPrimaryColor,
                      fontFamily: GoogleFonts.poppins().fontFamily),
                  navigatorKey:
                      serviceLocator<NavigationService>().navigatorKey,
                  onGenerateRoute: onGenerateRoute,
                  initialRoute: Routes.HOME,
                );
              },
            ),
          );
        });
  }
}
