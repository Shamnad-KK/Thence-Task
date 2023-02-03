import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thence_task/core/navigator_key.dart';
import 'package:thence_task/data/repositories/auth_repository_impl.dart';
import 'package:thence_task/data/repositories/firebase_repository_impl.dart';
import 'package:thence_task/data/repositories/local_repository_impl.dart';
import 'package:thence_task/data/repositories/product_remote_repository_impl.dart';
import 'package:thence_task/presentation/blocs/address/address_bloc.dart';
import 'package:thence_task/presentation/blocs/auth/auth_bloc.dart';
import 'package:thence_task/presentation/blocs/cart/cart_bloc.dart';
import 'package:thence_task/presentation/blocs/favorites/favorites_bloc.dart';
import 'package:thence_task/presentation/blocs/fcm/fcm_bloc.dart';
import 'package:thence_task/presentation/blocs/login/login_bloc.dart';
import 'package:thence_task/presentation/blocs/user_check/user_check_bloc.dart';
import 'package:thence_task/presentation/screens/auth/login_screen.dart';
import 'package:thence_task/presentation/widgets/bottom_nav_bar.dart';
import 'package:thence_task/theme/app_colors.dart';

import 'presentation/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'presentation/blocs/home/home_bloc.dart';
import 'presentation/blocs/home_choice_chips/home_choice_chips_bloc.dart';
import 'presentation/blocs/product_detail/product_detail_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  _foregroundMessageHandler();

  runApp(const MyApp());
}

Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('background message ${message.notification!.body}');
}

Future<void> _foregroundMessageHandler() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    sound: true,
    badge: true,
  );
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(414, 896),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider(
                create: (context) => FlutterLocalNotificationsPlugin(),
              ),
              RepositoryProvider(
                create: (context) => FirebaseAuth.instance,
              ),
              RepositoryProvider(
                create: (context) => FirebaseFirestore.instance,
              ),
              RepositoryProvider(
                create: (context) => FirebaseRepositoryImpl(
                  flutterLocalNotificationsPlugin:
                      context.read<FlutterLocalNotificationsPlugin>(),
                ),
              ),
              RepositoryProvider(
                create: (context) => AuthRepositoryImpl(
                  auth: context.read<FirebaseAuth>(),
                  firestore: context.read<FirebaseFirestore>(),
                ),
              ),
              RepositoryProvider(
                create: (context) => HomeRepositoryImpl(),
              ),
              RepositoryProvider(
                create: (context) => LocalRepositoryImpl(),
              ),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => HomeBloc(
                    homeRepository:
                        RepositoryProvider.of<HomeRepositoryImpl>(context),
                    localRepository:
                        RepositoryProvider.of<LocalRepositoryImpl>(context),
                  ),
                ),
                BlocProvider(
                  create: (context) => ProductDetailBloc(),
                ),
                BlocProvider(
                  create: (context) => HomeChoiceChipsBloc(),
                ),
                BlocProvider(
                  create: (context) => BottomNavBloc(),
                ),
                BlocProvider(
                  create: (context) => CartBloc(
                    localRepository:
                        RepositoryProvider.of<LocalRepositoryImpl>(context),
                  ),
                ),
                BlocProvider(
                  create: (context) => FavoritesBloc(
                    localRepositoryImpl:
                        RepositoryProvider.of<LocalRepositoryImpl>(context),
                  ),
                ),
                BlocProvider(
                  create: (context) => AddressBloc(),
                ),
                BlocProvider(
                  create: (context) => AuthBloc(
                    authRepository:
                        RepositoryProvider.of<AuthRepositoryImpl>(context),
                  )..add(GetAuthStatusEvent()),
                ),
                BlocProvider(
                  create: (context) => UserCheckBloc(
                    authRepository:
                        RepositoryProvider.of<AuthRepositoryImpl>(context),
                  ),
                ),
                BlocProvider(
                  create: (context) => LoginBloc(
                    authBloc: context.read<AuthBloc>(),
                    auth: FirebaseAuth.instance,
                    userCheckBloc: context.read<UserCheckBloc>(),
                    authRepository:
                        RepositoryProvider.of<AuthRepositoryImpl>(context),
                    firestore:
                        RepositoryProvider.of<FirebaseFirestore>(context),
                  ),
                ),
                BlocProvider(
                  create: (context) => FcmBloc(
                    firebaseRepositoryImpl:
                        context.read<FirebaseRepositoryImpl>(),
                    homeBloc: context.read<HomeBloc>(),
                  ),
                ),
              ],
              child: MaterialApp(
                navigatorKey: NavKeyHelper.navigatorKey,
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      iconTheme: IconThemeData(
                        color: AppColors.black,
                      )),
                  textTheme: GoogleFonts.montserratTextTheme(
                      Theme.of(context).textTheme),
                ),
                debugShowCheckedModeBanner: false,
                home: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthInitialized) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is Authenticated) {
                      return const BottomNavBar();
                    }
                    return const LoginScreen();
                  },
                ),
              ),
            ),
          );
        });
  }
}
