import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_sub_admin/application/booking_page_bloc/booking_page_event.dart';
import 'package:share_sub_admin/application/booking_page_bloc/booking_page_state.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/functions/sub_admin_function.dart';
import 'package:share_sub_admin/domain/model/room_booking_model.dart';

class BookingPageBloc extends Bloc<BookingPageEvent, BookingPageState> {
  List<RoomBookingModel> verificationPendingRooms = [];
  List<RoomBookingModel> checkOutVerificationPendingRooms = [];
  List<RoomBookingModel> paymentPendingRooms = [];
  List<RoomBookingModel> bookedRooms = [];
  List<RoomBookingModel> allRooms = [];
  BookingPageBloc() : super(InitialBookingPageState()) {
    on<OnShufleRoomBooking>((event, emit) async {
      emit(BookingShufleLoadingState());
      verificationPendingRooms = [];
      checkOutVerificationPendingRooms = [];
      paymentPendingRooms = [];
      bookedRooms = [];
      allRooms = [];
      if (event.listOfRooms.isNotEmpty) {
        for (int i = 0; i < event.listOfRooms.length; i++) {
          if (event.listOfRooms[i].containsKey(
              FirebaseFirestoreConst.firebaseFireStoreBookingDeatails)) {
            for (int j = 0;
                j <
                    event
                        .listOfRooms[i][FirebaseFirestoreConst
                            .firebaseFireStoreBookingDeatails]
                        .length;
                j++) {
              log('${event.listOfRooms[i][FirebaseFirestoreConst.firebaseFireStoreBookingDeatails][j]}');
              allRooms.add(RoomBookingModel.fromMap(event.listOfRooms[i]
                      [FirebaseFirestoreConst.firebaseFireStoreBookingDeatails]
                  [j]));
            }
          }
        }
      }

      for (RoomBookingModel i in allRooms) {
        if (i.paymentModel == null) {
          paymentPendingRooms.add(i);
        } else if (i.checkInCheckOutModel == null) {
          bookedRooms.add(i);
        } else if (i.checkInCheckOutModel!.request ==
            FirebaseFirestoreConst
                .firebaseFireStoreCheckInORcheckOutRequestForCheckInWaiting) {
          verificationPendingRooms.add(i);
        }
      }
      emit(BookingShufleSuccessState());
    });
    on<OnCheckoutButtonClicked>((event, emit) {
      emit(CheckoutLoadingState());
      log('checkout button clicked succefully');
      SubAdminFunction().roomCheckOutButonClicked(
          context: event.context, roomBookingModel: event.roomBookingModel);
      emit(CheckoutSuccessState());
    });
    on<OnCheckInButtonClicked>((event, emit) {
      emit(CheckInLoadingState());
      SubAdminFunction().roomAcceptButtonClick(
          context: event.context, roomBookingModel: event.roomBookingModel);
      emit(CheckInSuccessState());
    });
  }
}
