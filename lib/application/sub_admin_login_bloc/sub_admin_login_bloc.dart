

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_event.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_state.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/functions/shared_prefrence.dart';
import 'package:share_sub_admin/domain/functions/sub_admin_function.dart';
import 'package:share_sub_admin/domain/model/sub_admin_model.dart';
import 'package:share_sub_admin/presentation/alerts/toasts.dart';


class SubAdminLoginBloc extends Bloc<SubAdminLoginEvent, SubAdminLoginState> {
  String? userCredential;
  String? userId;
  SubAdminModel? subAdminModel;
  SubAdminLoginBloc() : super(SubAdminLoginIntialState()) {
    on<SubAdminAlredyLoginEvent>((event, emit) {
      userCredential = event.userCredential;
      userId = event.userId;
      SharedPreferencesClass.setUserid(event.userId);
      SharedPreferencesClass.setUserEmail(event.userCredential);
    });
    on<SubAdminDeatailAddingEvent>((event, emit)async{
      userId=event.userId;
      final instant=await FirebaseFirestore.instance.collection(FirebaseFirestoreConst.firebaseFireStoreSubAdminCollection).doc(userId).get();
      Map<String,dynamic> data=instant.data() as Map<String,dynamic>;
      subAdminModel=SubAdminModel.fromMap(data,event.userId);
      log('loginSuccess');
      emit(SubAdminLoginSuccessState());
    });
    on<SubAdminLoginLoadingEvent>((event, emit) async {
      emit(SubAdminLoginLoadingState());
      try {
        final userResult = await SubAdminFunction()
            .subAdminLoginPasswordAndEmailChecking(event.email, event.password);
        if (userResult != false) {
          userId = userResult;
          SharedPreferencesClass.setUserid(userId!);
          SharedPreferencesClass.setUserEmail(event.email);
          emit(SubAdminDeatailedAddigPendingState());
        } else {
          emit(SubAdminLoginErrorState());
        }
      } catch (e) {
        Toasts().toastWidget('$e');
      }
    });
  }
}
