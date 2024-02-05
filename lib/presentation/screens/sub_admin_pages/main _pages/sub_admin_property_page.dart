import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_bloc.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/functions/shared_prefrence.dart';
import 'package:share_sub_admin/domain/model/main_property_model.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/other_property_pages/hotel_property/sub_admin_property_adding_page.dart';
import 'package:share_sub_admin/presentation/widgets/commen_widget.dart';
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
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(
                    FirebaseFirestoreConst.firebaseFireStoreSubAdminCollection)
                .doc(context.read<SubAdminLoginBloc>().userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                List<dynamic> hotelList = data['hotel'];
                return ListView(
                  children: List.generate(hotelList.length, (index) {
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(FirebaseFirestoreConst
                              .firebaseFireStoreHotelCollection)
                          .doc(hotelList[index])
                          .snapshots(),
                      builder: (context, singelSnapshot) {
                        if (singelSnapshot.data != null) {
                          Map<String, dynamic> convertedeData =
                              singelSnapshot.data!.data()
                                  as Map<String, dynamic>;
                          MainPropertyModel singleData =
                              MainPropertyModel.fromMap(convertedeData);
                          return CommonWidget().hotelShowingContainer(
                              context, singleData, hotelList[index]);
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    );
                  }),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        Align(
          child: Container(
            height: MediaQuery.of(context).size.width * 0.1,
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width * 0.3,
            ),
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
                style: Styles().elevatedButtonBorderOnlyStyle(),
                onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return PropertyAddingPage();
                  }));
                },
                child: Text(
                  'Add Property',
                  style: Styles().elevatedButtonBorderOnlyTextStyle(context),
                )),
          ),
        ),
        // Align(
        //   alignment: Alignment.center,
        //   child: InkWell(
        //     onTap: () {

        //     },
        //     child: Container(
        //       margin: const EdgeInsets.all(10),
        //       height: 60,
        //       width: 60,
        //       decoration: Styles().customNextButtonDecoration(),
        //       child: Styles().roundedAddButtonChild(),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
