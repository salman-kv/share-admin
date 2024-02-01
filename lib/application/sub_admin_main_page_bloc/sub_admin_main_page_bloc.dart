import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_main_page_bloc/sub_admin_main_page_event.dart';
import 'package:share_sub_admin/application/sub_admin_main_page_bloc/sub_admin_main_page_state.dart';

class SubAdminMainPageBloc
    extends Bloc<SubAdminMainPageEvent, SubAdminMainPageState> {
      int index=0;
  SubAdminMainPageBloc() : super(SubAdminMainPageIndexState()) {

    on<NavBarClickingSubAdminMainPage>(
      (event, emit){ 
        index=event.index;
         emit(
        SubAdminMainPageIndexState(),
      );
      }
    );
  }
}
