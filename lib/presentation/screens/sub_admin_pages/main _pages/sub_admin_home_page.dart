import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_bloc.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/presentation/widgets/common_widget.dart';

class SubAdminHomePage extends StatelessWidget {
  const SubAdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
     const Padding(
        padding: EdgeInsets.all(10),
        child: Text("CheckIn'nd Rooms"),
      ),
      StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
                FirebaseFirestoreConst.firebaseFireStoreSubAdminCollection)
            .doc(BlocProvider.of<SubAdminLoginBloc>(context).userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> data = snapshot
                .data![FirebaseFirestoreConst.firebaseFireStoreHotelCollection];
            return data.isEmpty
                ? const Text('no hotel found')
                : Column(
                    children: List.generate(data.length, (index) {
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(FirebaseFirestoreConst
                              .firebaseFireStoreHotelCollection)
                          .doc(data[index])
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {                     
                          return CommonWidget().roomStatusShowingContainer(
                              hotelDeatails: snapshot.data!.data()!,
                              context: context,
                              hotelId: data[index]);
                        }
                        return Text('no hotel found');
                      },
                    );
                  }));
          } else {
            return Text('sdf');
          }
        },
      ),
    ]);
  }
}
