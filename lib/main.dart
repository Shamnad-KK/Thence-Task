import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:thence_task/controller/bottom_nav_controller.dart';
import 'package:thence_task/controller/home_controller.dart';
import 'package:thence_task/controller/product_detail_controller.dart';
import 'package:thence_task/helpers/app_colors.dart';
import 'package:thence_task/widgets/bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeController()),
        ChangeNotifierProvider(create: (context) => ProductDetailController()),
        ChangeNotifierProvider(create: (context) => BottomNavController()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(414, 896),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: AppColors.black,
                )),
            textTheme:
                GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
          ),
          debugShowCheckedModeBanner: false,
          home: const BottomNavBar(),
        ),
      ),
    );
  }
}
