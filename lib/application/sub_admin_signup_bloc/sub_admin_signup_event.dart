import 'package:image_picker/image_picker.dart';
import 'package:share_sub_admin/domain/model/sub_admin_model.dart';

abstract class SubAdminSignUpEvent{}

class OnclickSubAdminSignUpAuthentication extends SubAdminSignUpEvent{
}

class OnAddSubAdminSignUpImage extends SubAdminSignUpEvent{
  XFile image;
  OnAddSubAdminSignUpImage({required this.image});
}
class OnVarifySubAdminDetailsEvent extends SubAdminSignUpEvent{
  final SubAdminModel userModel;
  final String compire;

  OnVarifySubAdminDetailsEvent({required this.userModel, required this.compire});
}

class ManualEmailCheckingEvent extends SubAdminSignUpEvent{
  final String email;

  ManualEmailCheckingEvent({required this.email});
}
class ManualOtpCheckingEvent extends SubAdminSignUpEvent{
  final String otp;

  ManualOtpCheckingEvent({required this.otp});
}
class OnlyForLoadingevent extends SubAdminSignUpEvent{}