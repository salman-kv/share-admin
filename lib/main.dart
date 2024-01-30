import 'package:flutter/material.dart';
import 'package:share_sub_admin/presentation/screens/welcome_sub_admin/welcome_sub_admin.dart';import 'presentation/theme/sub_admin_theme.dart';

void main() {
  runApp(const SubAdmin());
}

class SubAdmin extends StatelessWidget {
  const SubAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: SubAdminThme().lightTheme,
      darkTheme: SubAdminThme().darkTheme,
      home: const WelcomeSubAdmin(),
    );
  }
}
