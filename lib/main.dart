import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_signup_bloc/sub_admin_signup_bloc.dart';
import 'package:share_sub_admin/domain/functions/shared_prefrence.dart';
import 'package:share_sub_admin/firebase_options.dart';
import 'package:share_sub_admin/presentation/screens/splash_screen/splash_screen.dart';
import 'presentation/theme/sub_admin_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform );
  final String? loginStatus=await SharedPreferencesClass.getUserId();
  runApp( SubAdmin(loginStatus: loginStatus,));
}

class SubAdmin extends StatelessWidget {
  final String? loginStatus;

  const SubAdmin({required this.loginStatus,super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SubAdminLoginBloc(),
        ),
        BlocProvider(
          create: (context) => SubAdminSignUpBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: SubAdminThme().lightTheme,
        darkTheme: SubAdminThme().darkTheme,
        home: SplashScreen(userId: loginStatus),
      ),
    );
  }
}
