import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_event.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_state.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_login/sub_admin_login_page.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/sub_admin_main_page.dart';
import 'package:share_sub_admin/presentation/screens/welcome_sub_admin/welcome_sub_admin.dart';

class SplashScreen extends StatelessWidget {
  final String? userId;
  const SplashScreen({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      if (userId == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) {
          return const WelcomeSubAdmin();
        }), (route) => false);
      } else if (userId == '') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) {
          return SubAdminLogin();
        }), (route) => false);
      } else {
        BlocProvider.of<SubAdminLoginBloc>(context)
            .add(SubAdminDeatailAddingEvent(userId: userId!));
      }
    });
    return SafeArea(
        child: Scaffold(
      body: BlocConsumer<SubAdminLoginBloc, SubAdminLoginState>(
        listener: (context, state) {
          if (state is SubAdminLoginSuccessState) {
            log('state success');
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) {
              return SubAdminMainPage();
            }), (route) => false);
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/images/splashScreenAnimation.json'),
            ],
          );
        },
      ),
    ));
  }
}
