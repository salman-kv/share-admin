import 'package:flutter/material.dart';
import 'package:share_sub_admin/domain/functions/sub_admin_function.dart';
import 'package:share_sub_admin/presentation/alerts/alert.dart';

class SubAdminMessagePage extends StatelessWidget {
  const SubAdminMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      Alerts().check(context: context,function: SubAdminFunction().subAdminLogOut,param: context);
    }, child: Text('sdf'));
  }
}