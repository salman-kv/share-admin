import 'dart:developer';
import 'package:email_otp/email_otp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_sub_admin/application/sub_admin_signup_bloc/sub_admin_signup_event.dart';
import 'package:share_sub_admin/application/sub_admin_signup_bloc/sub_admin_signup_state.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/functions/shared_prefrence.dart';
import 'package:share_sub_admin/domain/functions/sub_admin_function.dart';
import 'package:share_sub_admin/presentation/widgets/commen_widget.dart';
class SubAdminSignUpBloc extends Bloc<SubAdminSignUpEvent, SubAdminSignUpState> {
  // UserCredential? userCredential;
  String? email;
  XFile? image;
  String? userid;
  EmailOTP myAuth = EmailOTP();
  SubAdminSignUpBloc() : super(InitialSubAdminSignUp()) {
    on<OnclickSubAdminSignUpAuthentication>(
      (event, emit) async {
        try {
          emit(SubAdminSignupLoading());
          final authResult = await SubAdminFunction().signInWithGoogle();
          if (authResult != null) {
            email = authResult!.user!.email!;
            final userReturnId = await SubAdminFunction()
                .checkSubAdminIsAlredyTheirOrNot(
                    email!, FirebaseFirestoreConst.firebaseFireStoreEmail);
            if (userReturnId != false) {
              userid = userReturnId;
              SharedPreferencesClass.setUserid(userid!);
              SharedPreferencesClass.setUserEmail(email!);
              emit(SubAdminAlredySignupState(
                  userCredential: email!, userId: userReturnId));
            } else {
              emit(SubAdminSignupAuthenticationSuccess());
            }
          } else {
            emit(InitialSubAdminSignUp());
            log('Some user error');
          }
        } catch (e) {
          emit(InitialSubAdminSignUp());
          CommonWidget().toastWidget('$e');
          log('$e');
        }
      },
    );
    on<OnVarifySubAdminDetailsEvent>((event, emit) async {
      emit(SubAdminSignupLoading());
      final userResult =
          await SubAdminFunction().addSubAdminDeatails(event.userModel, event.compire);
      userid = userResult;
      SharedPreferencesClass.setUserid(userid!);
      SharedPreferencesClass.setUserEmail(email!);
        image=null;
      emit(SubAdminVerifiedWithMoredataState(
          userCredential: email!, userId: userResult));
    });
     on<OnlyForLoadingevent>((event, emit){
      emit(SubAdminSignupLoading());
    });
    on<OnAddSubAdminSignUpImage>((event, emit) {
      image = event.image;
      emit(SubAdminSignupImagePickSuccess(image: event.image));
    });
    on<ManualEmailCheckingEvent>((event, emit) async {
      emit(ManualEmailCheckingLoadingState());
      myAuth.setConfig(
          appEmail: "kvsalu16@gmail.com",
          appName: 'email otp',
          userEmail: event.email,
          otpLength: 4,
          otpType: OTPType.digitsOnly);
      final userReturnId = await SubAdminFunction().checkSubAdminIsAlredyTheirOrNot(
          event.email, FirebaseFirestoreConst.firebaseFireStoreEmail);
      if (userReturnId == false) {
        var val = await myAuth.sendOTP();
        if (val) {
          email = event.email;
          emit(ManualEmailCheckingSuccessState(email: event.email));
        } else {
          emit(SubAdminSignupErrorState());
          emit(InitialSubAdminSignUp());
        }
      } else {
        emit(SubAdminAlreadySignupErrorState());
      }
    });
    on<ManualOtpCheckingEvent>((event, emit) async {
      emit(ManualEmailCheckingLoadingState());
      var res = await myAuth.verifyOTP(otp: event.otp);
      if (res) {
        emit(ManualOtpCheckingSuccessState());
      } else {
        emit(SubAdminOtpVerifyErrorState());
      }
    });
   
  }
}
