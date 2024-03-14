import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_bloc.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/presentation/widgets/common_widget.dart';

class SubAdminHomePage extends StatelessWidget {
  const SubAdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          "Properties",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
                FirebaseFirestoreConst.firebaseFireStoreSubAdminCollection)
            .doc(BlocProvider.of<SubAdminLoginBloc>(context).userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.data()!.containsKey('hotel')) {
              List<dynamic> data = snapshot.data![
                  FirebaseFirestoreConst.firebaseFireStoreHotelCollection];
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Lottie.asset('assets/images/property.json'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'No property found',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.grey),
                  )
                ],
              );
            }
          } else {
            return Text('sdf');
          }
        },
      ),
    ]);
  }
}
