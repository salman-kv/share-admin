import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_sub_admin/presentation/cosnt/const_colors.dart';

class CommonWidget {
  toastWidget(String toastMessage) {
    return Fluttertoast.showToast(
        msg: toastMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  errorSnackBar(String errorSnackBarMessage, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(10),
        duration:const Duration(seconds: 1),
        backgroundColor: Colors.red,
        content: Text(
          errorSnackBarMessage,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

// room status details showing on subadmins home

  roomStatusShowingContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ConstColors().mainColorpurple.withOpacity(0.3)),
      constraints: const BoxConstraints(minHeight: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                    image: AssetImage('assets/images/room.jpg'),
                    fit: BoxFit.fill)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Room NO : 12',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Alocated user',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          userShowingComntainer(context),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 12),
            child: Text(
              'Checkin : 10-03-2020 10:30 Am',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ],
      ),
    );
  }

  // user showing rounder condainer

  userShowingComntainer(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), color: MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.white : Colors.black),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(4),
            child: Image.asset('assets/images/profile.png'),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('User name',style: Theme.of(context).textTheme.displayMedium,),
            ),
          ),
          const Spacer(),
          const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15),
            child: Icon(Icons.arrow_forward_ios),
          )
          

        ],
      ),
    );
  }
}
