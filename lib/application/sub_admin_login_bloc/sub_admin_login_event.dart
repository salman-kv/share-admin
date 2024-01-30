

abstract class SubAdminLoginEvent{}

class SubAdminAlredyLoginEvent extends SubAdminLoginEvent{
  final String userCredential;
  final String userId;
  SubAdminAlredyLoginEvent( {required this.userId,required this.userCredential});
}

class SubAdminLoginLoadingEvent extends SubAdminLoginEvent{
  final String email;
  final String password;

  SubAdminLoginLoadingEvent({required this.email, required this.password});
  
}

class SubAdminLoginSuccessEvent extends SubAdminLoginEvent{
  final String userId;
  SubAdminLoginSuccessEvent({required this.userId});
}