import 'package:flutter/material.dart';
import 'package:share_sub_admin/presentation/screens/welcome_sub_admin/welcome_sub_admin_more2.dart';
import 'package:share_sub_admin/presentation/widgets/styles.dart';

class WelcomeSubAdminMore extends StatelessWidget {
  const WelcomeSubAdminMore({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 7,
              child: Container(
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/images/userMoreImage.jpg'),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(
                          MediaQuery.of(context).size.width * 0.4,
                          MediaQuery.of(context).size.width * 0.2),
                      bottomRight: Radius.elliptical(
                          MediaQuery.of(context).size.width * 0.7,
                          MediaQuery.of(context).size.width * 0.65),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: MediaQuery.of(context).platformBrightness ==
                                Brightness.light
                            ? const Color.fromARGB(255, 126, 126, 126)
                            : const Color.fromARGB(255, 255, 255, 255),
                        blurRadius: 6,
                        blurStyle: BlurStyle.outer,
                      ),
                    ]),
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.009,
                      ),
                      Text('Share Your Property',
                          style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.009,
                      ),
                      Text(
                        'Dont worry you can share your property in to the world',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const WelcomeSubAdminMore2();
                },
              )),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: Styles().customNextButtonDecration(),
                  child: Styles().customNextButtonChild(),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
