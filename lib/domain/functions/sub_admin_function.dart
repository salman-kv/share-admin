import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/functions/shared_prefrence.dart';
import 'package:share_sub_admin/domain/model/main_property_model.dart';
import 'package:share_sub_admin/domain/model/room_model.dart';
import 'package:share_sub_admin/domain/model/sub_admin_model.dart';
import 'package:share_sub_admin/presentation/alerts/toasts.dart';

class SubAdminFunction {
  // -----------------------------------------------------------------------------------------------------------

  // add user in to firestore

  addSubAdminDeatails(SubAdminModel subAdminModel, String compire) async {
    final instant = FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreSubAdminCollection);
    await instant.where(compire, isEqualTo: subAdminModel.email).get();
    final result = await instant.add(subAdminModel.fromMap());
    return result.id;
  }
  // add hotel deatails to firestore

  addSubAdminHotelDeatails(MainPropertyModel mainPropertyModel) async {
    final instant = FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreHotelCollection);
    final result = await instant.add(mainPropertyModel.toMap());
    return result.id;
  }

  addEditedSubAdminHotelDeatails(
      MainPropertyModel mainPropertyModel, String hotelId) async {
    final instant = FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreHotelCollection);
    await instant.doc(hotelId).update(mainPropertyModel.toMap());
  }

  addHotelIdToSubAdminDocument(String userId, String hotelId) async {
    log(userId);
    Map<String, dynamic> userData = {};
    final instant = FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreSubAdminCollection);
    await instant.doc(userId).get().then((value) {
      userData = value.data() as Map<String, dynamic>;
    });
    if (userData['hotel'] == null) {
      userData['hotel'] = [hotelId];
    } else {
      userData['hotel'].add(hotelId);
    }
    instant.doc(userId).update(userData);
  }

  // checking and authenticate user deatailes and send user credential

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSubAdmin = await GoogleSignIn().signIn();
      final googleAuth = await googleSubAdmin?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log('$e');
    }
  }

// -----------------------------------------------------------------------------------------------------------

// -----------------------------------------------------------------------------------------------------------

  // add room deatailes

  addSubAdminRoomDeatails(RoomModel roomModel) async {
    final instant = FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection);
    final result = await instant.add(RoomModel.toMap(roomModel));
    return result.id;
  }

  addSubAdminEditedRoomDeatails(RoomModel roomModel, String roomId) async {
    final instant = FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
        .doc(roomId)
        .update(RoomModel.toMap(roomModel));
    //  await instant.add(RoomModel.toMap(roomModel));
    // return result.id;
  }

  addRoomlIdToHotelDocument(String hotelId, String roomId) async {
    log('hotelid');
    log(hotelId);
    Map<String, dynamic> userData = {};
    final instant = FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreHotelCollection);
    await instant.doc(hotelId).get().then((value) {
      userData = value.data() as Map<String, dynamic>;
    });
    if (userData[FirebaseFirestoreConst.firebaseFireStoreRooms] == null) {
      userData[FirebaseFirestoreConst.firebaseFireStoreRooms] = [roomId];
    } else {
      userData[FirebaseFirestoreConst.firebaseFireStoreRooms].add(roomId);
    }
    instant.doc(hotelId).update(userData);
  }

  // adding room deatails in to room collection to firebase

  addingRoomDeatails({required String hotelId}) async {
    var instant = FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection);
    instant.add({'sdf': 'hai'});
  }

// -----------------------------------------------------------------------------------------------------------

// -----------------------------------------------------------------------------------------------------------

  // user pick image and send the image file

  subAdminPickImage() async {
    try {
      var a = await ImagePicker().pickImage(source: ImageSource.gallery);
      return a;
    } catch (e) {
      log('$e');
    }
  }

  // user pick multiple images and sent image Xfile

  subAdminPickMultipleImage() async {
    try {
      List<XFile> listOfImage = await ImagePicker().pickMultiImage();
      List<String> listOfStringImage = listOfImage.map((e) {
        return e.path;
      }).toList();
      return listOfStringImage;
    } catch (e) {
      log('$e');
    }
  }

  // store image in to image path in firebase and send back the download url as image url

  uploadImageToFirebase(XFile xfile) async {
    final ref = FirebaseStorage.instance.ref('image').child(xfile.name);
    await ref.putFile(File(xfile.path));
    final imageUrl = await ref.getDownloadURL();
    return imageUrl;
  }

  // store image in to image path in firebase and send back the download url as image url for a list of image

  uploadListImageToFirebase(List<dynamic> listImage) async {
    List<String> image = [];
    for (String i in listImage) {
      final ref = FirebaseStorage.instance
          .ref(FirebaseFirestoreConst.firebaseFireStoreImages)
          .child(i);
      await ref.putFile(File(i));
      final imgeUrl = await ref.getDownloadURL();
      image.add(imgeUrl);
    }
    return image;
  }

// -----------------------------------------------------------------------------------------------------------

  // checkig user deatailes already logind or not , if login sent the id otherwise send false

  checkSubAdminIsAlredyTheirOrNot(String email, String compare) async {
    final instant = FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreSubAdminCollection);
    final val = await instant.where(compare, isEqualTo: email).get();
    if (val.docs.isNotEmpty) {
      return val.docs.first.id;
    } else {
      return false;
    }
  }

  // user login by email and password and send the id of user

  subAdminLoginPasswordAndEmailChecking(String email, String password) async {
    try {
      final instant = FirebaseFirestore.instance.collection(
          FirebaseFirestoreConst.firebaseFireStoreSubAdminCollection);
      final val = await instant
          .where(FirebaseFirestoreConst.firebaseFireStoreEmail,
              isEqualTo: email)
          .get();
      if (val.docs.isNotEmpty) {
        if (val.docs.first[FirebaseFirestoreConst.firebaseFireStorePassword] ==
            password) {
          return val.docs.first.id;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      Toasts().toastWidget('$e');
    }
  }

  // fetch all data of a single user by id

  fecchSubAdminDataById(String userId) async {
    final val = await FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreSubAdminCollection)
        .doc(userId)
        .get();
    var a = SubAdminModel(
        userId: userId,
        email: val['email'],
        name: val['name'],
        password: val['password'],
        phone: val['phone'],
        imagePath: val['image']);
    return a;
  }

  // get current postional of user

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('Location service is disabled');
      return Future.error('Location service is disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        log('Location permission is denied');
        return Future.error('Location permission is denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      log('Location permission denied permenently');
      return Future.error('Location permission denied permenently');
    }
    var currentPostion = await Geolocator.getCurrentPosition();
    return currentPostion;
  }

  // delete a room from a hotel

  deleteRoomFromHotel({required String hotelId, required String roomId}) async {
    final instant = await FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreHotelCollection)
        .doc(hotelId)
        .get();
    Map<String, dynamic> data = instant.data() as Map<String, dynamic>;
    List<dynamic> list = data[FirebaseFirestoreConst.firebaseFireStoreRooms];
    list.remove(roomId);
    await FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreHotelCollection)
        // ignore: use_build_context_synchronously
        .doc(hotelId)
        .update({FirebaseFirestoreConst.firebaseFireStoreRooms: list});
    await FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
        .doc(roomId)
        .delete();
  }

  // delete an hotel from a user (also delete all rooms from the hotel)

  deleteHotelFromSubAdmin(
      {required MainPropertyModel propertyModel,
      required String hotelId}) async {
    String userId = await SharedPreferencesClass.getUserId();
    final instant = await FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreSubAdminCollection)
        .doc(userId)
        .get();
    Map<String, dynamic> data = instant.data() as Map<String, dynamic>;
    List<dynamic> list = data['hotel'];
    list.remove(hotelId);
    await FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreSubAdminCollection)
        .doc(userId)
        .update({'hotel': list});

    var hotelInstant = await FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreHotelCollection)
        .doc(hotelId)
        .get();
    Map<String, dynamic> hotelData =
        hotelInstant.data() as Map<String, dynamic>;
    if (hotelData[FirebaseFirestoreConst.firebaseFireStoreRooms] != null) {
      List<dynamic> roomList =
          hotelData[FirebaseFirestoreConst.firebaseFireStoreRooms];
      for (var i in roomList) {
        await FirebaseFirestore.instance
            .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
            .doc(i)
            .delete();
      }
    }

    await FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreHotelCollection)
        .doc(hotelId)
        .delete();
  }
}
