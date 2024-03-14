
abstract class SubAdminLoginState{}

class SubAdminLoginIntialState extends SubAdminLoginState{}
class SubAdminLoginLoadingState extends SubAdminLoginState{}
class SubAdminLoginSuccessState extends SubAdminLoginState{}
class SubAdminLoginErrorState extends SubAdminLoginState{}
class SubAdminDetailedAddedToTheBlocState extends SubAdminLoginState{}
class FreshSubAdminState extends SubAdminLoginState{}
class OneTimeLoginedSubAdminState extends SubAdminLoginState{}
class AlreadyLoginedSubAdminState extends SubAdminLoginState{}
class SubAdminDeatailedAddigPendingState extends SubAdminLoginState{}
class UserDeatailsUpdatedState extends SubAdminLoginState{
  final String image;

  UserDeatailsUpdatedState({required this.image});
}
class UserDeatailsUpdatingState extends SubAdminLoginState{}
class UserImageUpdatedState extends SubAdminLoginState{}
class UserDeatailedAddigPendingState extends SubAdminLoginState{}