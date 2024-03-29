import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_event.dart';
import 'package:share_sub_admin/application/sub_admin_main_page_bloc/sub_admin_main_page_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_main_page_bloc/sub_admin_main_page_event.dart';
import 'package:share_sub_admin/application/sub_admin_main_page_bloc/sub_admin_main_page_state.dart';
import 'package:share_sub_admin/presentation/cosnt/const_colors.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/main%20_pages/sub_admin_booking_page.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/main%20_pages/sub_admin_home_page.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/main%20_pages/sub_admin_message_page.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/main%20_pages/sub_admin_property_page.dart';
import 'package:share_sub_admin/presentation/widgets/common_widget.dart';
import 'package:share_sub_admin/presentation/widgets/notification_widget.dart';

class SubAdminMainPage extends StatelessWidget {
  SubAdminMainPage({ super.key});

  List<Widget> screens = const [
    SubAdminHomePage(),
    SubAdminBookinPage(),
    SubAdminPropertyPage()
  ];

  @override
  Widget build(BuildContext context) {
    var key=GlobalKey<ScaffoldState>();
    return BlocProvider(
      create: (context) => SubAdminMainPageBloc(),
      child: BlocConsumer<SubAdminMainPageBloc, SubAdminMainPageState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              key: key,
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      key.currentState!.openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu_outlined,
                      size: 30,
                    )),
                actions: [
                  NotificationWidget().notificationButton(context: context),
                ],
              ),
              body: screens[context.watch<SubAdminMainPageBloc>().index],
              drawer:CommonWidget().drawerReturnFunction(context),
              bottomNavigationBar: MotionTabBar(
                initialSelectedTab: 'Home',
                tabBarColor: MediaQuery.of(context).platformBrightness ==
                        Brightness.light
                    ? Colors.white
                    : Colors.black,
                labels: const ["Home", "Booking", "Property"],
                textStyle: Theme.of(context).textTheme.displaySmall,
                icons: const [
                  Icons.window_rounded,
                  Icons.calendar_month,
                  Icons.maps_home_work_rounded
                ],
                onTabItemSelected: (value) {
                  BlocProvider.of<SubAdminMainPageBloc>(context)
                      .add(NavBarClickingSubAdminMainPage(index: value));
                },
                tabIconColor: MediaQuery.of(context).platformBrightness ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
                tabSelectedColor: MediaQuery.of(context).platformBrightness ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
                tabIconSize: 30,
                tabIconSelectedColor:
                    MediaQuery.of(context).platformBrightness ==
                            Brightness.light
                        ? const Color.fromARGB(255, 255, 255, 255)
                        : const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
