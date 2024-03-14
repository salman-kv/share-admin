
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_state.dart';
import 'package:share_sub_admin/presentation/cosnt/const_colors.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/other_property_pages/profile/edit_profile_page.dart';
import 'package:share_sub_admin/presentation/widgets/common_widget.dart';
import 'package:share_sub_admin/presentation/widgets/styles.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubAdminLoginBloc, SubAdminLoginState>(
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
                appBar: AppBar(),
                body: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.65,
                        decoration: BoxDecoration(
                            color: ConstColors().mainColorpurple.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * (.13),
                            ),
                            Text(
                              BlocProvider.of<SubAdminLoginBloc>(context)
                                  .subAdminModel!
                                  .name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    BlocProvider.of<SubAdminLoginBloc>(context)
                                        .subAdminModel!
                                        .email,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  Text(
                                    BlocProvider.of<SubAdminLoginBloc>(context)
                                        .subAdminModel!
                                        .phone.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.04,
                              decoration: Styles().elevatedButtonDecoration(),
                              child: ElevatedButton(
                                style: Styles().elevatedButtonStyle(),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return EditProfilePage();
                                    },
                                  ));
                                },
                                child: Text(
                                  'Edit profile',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.dark
                                        ? Colors.black
                                        : Colors.white,
                                width: 20,
                                strokeAlign: BorderSide.strokeAlignOutside),
                            borderRadius: BorderRadius.circular(1000)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: CommonWidget().profileNetworkImage(
                              context: context,
                              image: BlocProvider.of<SubAdminLoginBloc>(context)
                                  .subAdminModel!
                                  .imagePath,
                            )),
                      ),
                    ),
                    // ElevatedButton(onPressed: (){
                    //   BlocProvider.of<MainUserBloc>(context).add(OnColorChangeEvent());
                    // }, child: Text('color'))
                  ],
                )));
      },
    );
  }
}
