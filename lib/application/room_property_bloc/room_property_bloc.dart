import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_sub_admin/application/main_property_bloc/main_property_event.dart';
import 'package:share_sub_admin/application/room_property_bloc/room_property_event.dart';
import 'package:share_sub_admin/application/room_property_bloc/room_property_state.dart';
import 'package:share_sub_admin/domain/functions/sub_admin_function.dart';
import 'package:share_sub_admin/domain/model/main_property_model.dart';
import 'package:share_sub_admin/domain/model/room_model.dart';

class RoomPropertyBloc extends Bloc<RoomPropertyEvent, RoomPropertyState> {
  MainPropertyModel? propertyModel;
  String? hotelId;
  List<String> features = [];
  List<XFile> image = [];
  int? numberOfBed;
  RoomPropertyBloc() : super(RoomPropertyBlocInitial()) {
    on<OnSettingHotelIdEvent>((event, emit) {
      hotelId = event.hotelId;
    });
    on<OnFeatureAddingEvent>((event, emit) {
      features.add(event.text);
      emit(FeatureAddedState());
    });
    on<OnFeatureDeletedEvent>((event, emit) {
      features.remove(event.text);
      emit(FeatureDeletedState());
    });
    on<OnClickToAddMultipleImageEvent>((event, emit) async {
      var nweImage = await SubAdminFunction().subAdminPickMultipleImage();
      image.addAll(nweImage);
      emit(MultipleImageAddedState());
    });
    on<OnBedSelectEvent>((event, emit) {
      numberOfBed = event.numberOfBed;
      emit(NumberOfBedSelectedState());
    });
    on<OnAddRoomDeatailsEvent>((event, emit) async {
      emit(RoomDeatailsSubmittingLoadingState());
      final returnimage=await SubAdminFunction().uploadListImageToFirebase(image);
      final RoomModel roomModel = RoomModel(
          hotelId: hotelId!,
          hotelName: propertyModel!.propertyNmae,
          roomNumber: event.roomNumber,
          price: event.price,
          numberOfBed: numberOfBed!,
          features: features,
          images: returnimage,
          availability:true 
          );
      String roomId= await SubAdminFunction().addSubAdminRoomDeatails(roomModel);
      SubAdminFunction().addRoomlIdToHotelDocument(hotelId!, roomId);
      emit(RoomDeatailsSubmittedState());
    });
  }
}
