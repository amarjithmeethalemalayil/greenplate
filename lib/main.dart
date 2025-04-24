import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/features/bottom_nav/presentation/cubit/bottom_nav_cubit.dart';
import 'package:green_plate/features/bottom_nav/presentation/pages/bottom_nav.dart';
import 'package:green_plate/features/home/presentation/cubit/tab_bar_cubit.dart';


Future<void> main() async {
   await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375.0, 812.0),
      minTextAdapt: true,
      builder: (context, snapshot) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => TabBarCubit()),
            BlocProvider(create: (_) => BottomNavCubit()),
          ],
          child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const BottomNav(),
          ),
        );
      },
    );
  }
}



