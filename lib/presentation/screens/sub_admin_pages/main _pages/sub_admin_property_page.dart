import 'package:flutter/material.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/property_adding/sub_admin_property_adding_page.dart';
import 'package:share_sub_admin/presentation/widgets/styles.dart';

class SubAdminPropertyPage extends StatelessWidget {
  const SubAdminPropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Your Properties',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              Text('sdfsdfsdf'),
              Text('sdfsdfsdf'),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              return PropertyAddingPage();
            }));
          },
          child: Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.all(10),
              height: 60,
              width: 60,
              decoration: Styles().customNextButtonDecoration(),
              child: Styles().roundedAddButtonChild(),
            ),
          ),
        ),
      ],
    );
  }
}
