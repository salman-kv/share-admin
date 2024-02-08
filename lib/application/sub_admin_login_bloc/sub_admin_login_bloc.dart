

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_event.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_state.dart';
import 'package:share_sub_admin/domain/functions/shared_prefrence.dart';
import 'package:share_sub_admin/domain/functions/sub_admin_function.dart';
import 'package:share_sub_admin/presentation/alerts/toasts.dart';

class SubAdminLoginBloc extends Bloc<SubAdminLoginEvent, SubAdminLoginState> {
  String? userCredential;
  String? userId;
  SubAdminLoginBloc() : super(SubAdminLoginIntialState()) {
    on<SubAdminAlredyLoginEvent>((event, emit) {
      userCredential = event.userCredential;
      userId = event.userId;
      SharedPreferencesClass.setUserid(event.userId);
      SharedPreferencesClass.setUserEmail(event.userCredential);
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
          emit(SubAdminLoginSuccessState());
        } else {
          emit(SubAdminLoginErrorState());
        }
      } catch (e) {
        Toasts().toastWidget('$e');
      }
    });
  }
}
