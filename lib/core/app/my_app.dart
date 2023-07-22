import 'package:cocktail/config/routes/router.dart';
import 'package:evolvex_lib/evolvex_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme/theme_bloc.dart';
import '../injection_container.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        builder: (context, child) {
          return BlocProvider<ThemeBloc>(
            create: (context) => sl(),
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return MaterialApp.router(
                  routerConfig: router,
                  debugShowCheckedModeBanner: false,
                  title: 'Cocktail',
                  theme: ThemeData(
                      primarySwatch: state is ChangeThemeState
                          ? state.color
                          : Styles.colors.kPrimaryColor,
                      fontFamily: GoogleFonts.poppins().fontFamily),
                );
              },
            ),
          );
        });
  }
}
