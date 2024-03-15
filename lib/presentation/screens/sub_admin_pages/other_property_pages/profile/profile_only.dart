import 'package:flutter/material.dart';
import 'package:share_sub_admin/domain/model/user_model.dart';
import 'package:share_sub_admin/presentation/cosnt/const_colors.dart';
import 'package:share_sub_admin/presentation/widgets/common_widget.dart';
import 'package:share_sub_admin/presentation/widgets/styles.dart';

class ProfileOnly extends StatelessWidget {
  UserModel userModel;
   ProfileOnly({required this.userModel,super.key});

  @override
  Widget build(BuildContext context) {
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
                              userModel.name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    userModel.email,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  Text(
                                    userModel
                                        .phone.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                ],
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
                              image: userModel
                                  .imagePath,
                            )),
                      ),
                    ),
                    // ElevatedButton(onPressed: (){
                    //   BlocProvider.of<MainUserBloc>(context).add(OnColorChangeEvent());
                    // }, child: Text('color'))
                  ],
                )));
  }
}