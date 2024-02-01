import 'package:flutter/material.dart';
import 'package:share_sub_admin/presentation/screens/welcome_sub_admin/welcome_sub_admin_more.dart';
import 'package:share_sub_admin/presentation/widgets/designed_text.dart';
import 'package:share_sub_admin/presentation/widgets/styles.dart';

class WelcomeSubAdmin extends StatelessWidget {
  const WelcomeSubAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DesignedText().welcomeShareText(context),
                  Text(
                    'Find Your safe stay',
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.1,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: Styles().elevatedButtonDecoration(),
              child: ElevatedButton(
                  style: Styles().elevatedButtonStyle(),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return const WelcomeSubAdminMore();
                    },));
                  },
                  child: Text(
                    'Get Start',
                    style: Styles().elevatedButtonTextStyle(),
                  )),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    ));
  }
}
