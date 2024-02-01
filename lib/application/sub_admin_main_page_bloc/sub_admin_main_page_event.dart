abstract class SubAdminMainPageEvent{}

class NavBarClickingSubAdminMainPage extends SubAdminMainPageEvent{
  final int index;

  NavBarClickingSubAdminMainPage({required this.index});
}