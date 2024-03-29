import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_event.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_state.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/sub_admin_main_page.dart';
import 'package:share_sub_admin/presentation/widgets/styles.dart';

class SubAdminSignUpsuccess extends StatelessWidget {
  const SubAdminSignUpsuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
          child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image.asset(
                'assets/images/mapImage.jpg',
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    'Welcome to Share',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      'You are all set now, Lets find your perfect room with us',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            BlocListener<SubAdminLoginBloc, SubAdminLoginState>(
              listener: (context, state) {
                if(state is SubAdminLoginSuccessState){
                  Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (ctx) {
                        return SubAdminMainPage();
                        // return  SubAdminMainPage(userId: context.read<SubAdminLoginBloc>().userId!,);
                      }), (route) => false);
                }
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.width * 0.1,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: Styles().elevatedButtonDecoration(),
                child: ElevatedButton(
                    style: Styles().elevatedButtonStyle(),
                    onPressed: () async {
                      BlocProvider.of<SubAdminLoginBloc>(context).add(
                          SubAdminDeatailAddingEvent(
                              userId:
                                  BlocProvider.of<SubAdminLoginBloc>(context)
                                      .userId!));
                    },
                    child: Text(
                      'Finish',
                      style: Styles().elevatedButtonTextStyle(context),
                    )),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
