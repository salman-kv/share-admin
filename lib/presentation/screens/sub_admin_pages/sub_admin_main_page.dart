import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_main_page_bloc/sub_admin_main_page_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_main_page_bloc/sub_admin_main_page_event.dart';
import 'package:share_sub_admin/application/sub_admin_main_page_bloc/sub_admin_main_page_state.dart';
import 'package:share_sub_admin/presentation/cosnt/const_colors.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/main%20_pages/sub_admin_booking_page.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/main%20_pages/sub_admin_home_page.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/main%20_pages/sub_admin_message_page.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/main%20_pages/sub_admin_property_page.dart';
import 'package:share_sub_admin/presentation/widgets/commen_widget.dart';

class SubAdminMainPage extends StatelessWidget {
  final String userId;
  SubAdminMainPage({required this.userId,super.key});

  List<Widget> screens = const [
    SubAdminHomePage(),
    SubAdminBookinPage(),
    SubAdminMessagePage(),
    SubAdminPropertyPage()
  ];

  @override
  Widget build(BuildContext context) {
    context.read<SubAdminLoginBloc>().userId=userId;
    return BlocProvider(
      create: (context) => SubAdminMainPageBloc(),
      child: BlocConsumer<SubAdminMainPageBloc, SubAdminMainPageState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: const Icon(
                  Icons.menu_outlined,
                  size: 30,
                ),
                actions: const [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.notifications_active_outlined,
                      size: 28,
                    ),
                  )
                ],
              ),
              body: screens[context.watch<SubAdminMainPageBloc>().index],
              bottomNavigationBar: MotionTabBar(
                initialSelectedTab: 'Home',
                tabBarColor: MediaQuery.of(context).platformBrightness ==
                        Brightness.light
                    ? Colors.white
                    : Colors.black,
                labels: const ["Home", "Booking", "Message", "Property"],
                textStyle: Theme.of(context).textTheme.displaySmall,
                icons: const [
                  Icons.window_rounded,
                  Icons.calendar_month,
                  Icons.message_rounded,
                  Icons.maps_home_work_rounded
                ],
                onTabItemSelected: (value) {
                  BlocProvider.of<SubAdminMainPageBloc>(context)
                      .add(NavBarClickingSubAdminMainPage(index: value));
                },
                tabIconColor: ConstColors().mainColorpurple,
                tabSelectedColor: ConstColors().mainColorpurple,
                tabIconSize: 30,
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
