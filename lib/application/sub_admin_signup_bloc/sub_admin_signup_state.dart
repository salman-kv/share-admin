import 'package:image_picker/image_picker.dart';

abstract class SubAdminSignUpState{}

class InitialSubAdminSignUp extends SubAdminSignUpState{}
class SubAdminSignupLoading extends SubAdminSignUpState{}
class SubAdminSignupAuthenticationSuccess extends SubAdminSignUpState{}
class SubAdminSignupImagePickSuccess extends SubAdminSignUpState{
  final XFile image;
  SubAdminSignupImagePickSuccess({required this.image});
}
class SubAdminAlredySignupState extends SubAdminSignUpState{
 final  String userCredential;
 final String userId;
  SubAdminAlredySignupState({required this.userId,required this.userCredential});
}
class SubAdminVerifiedWithMoredataState extends SubAdminSignUpState{
  final  String userCredential;
 final String userId;

  SubAdminVerifiedWithMoredataState({required this.userCredential, required this.userId});
}
class ManualEmailCheckingLoadingState extends SubAdminSignUpState{}
class ManualEmailCheckingSuccessState extends SubAdminSignUpState{
  final String email;

  ManualEmailCheckingSuccessState({required this.email});
}
class ManualOtpCheckingSuccessState extends SubAdminSignUpState{}
class SubAdminSignupErrorState extends SubAdminSignUpState{}
class SubAdminOtpVerifyErrorState extends SubAdminSignUpState{}
class SubAdminAlreadySignupErrorState extends SubAdminSignUpState{}