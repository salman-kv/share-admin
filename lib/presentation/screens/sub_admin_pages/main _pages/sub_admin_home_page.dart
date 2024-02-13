import 'package:flutter/material.dart';
import 'package:share_sub_admin/presentation/widgets/commen_widget.dart';

class SubAdminHomePage extends StatelessWidget {
  const SubAdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
                    dividerHeight: 0,
                    labelStyle: Theme.of(context).textTheme.titleLarge,
                    
                    tabs: const <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('booked'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Available',),
                    ),
                  ]),
        ),
        body: TabBarView(children: [
                  ListView(
                  children: [
                    Padding(
                      padding:const  EdgeInsets.all(10),
                      child: CommonWidget().roomStatusShowingContainer(context)
                    ),
                    Padding(
                      padding:const  EdgeInsets.all(10),
                      child: CommonWidget().roomStatusShowingContainer(context)
                    ),
                    Padding(
                      padding:const  EdgeInsets.all(10),
                      child: CommonWidget().roomStatusShowingContainer(context)
                    ),
                  ],
                ),
                ListView(
                  children: [
                    Padding(
                      padding:const  EdgeInsets.all(10),
                      child: CommonWidget().roomStatusShowingContainer(context)
                    ),
                  ],
                ),
                ]),
      ),
    );
  }
}